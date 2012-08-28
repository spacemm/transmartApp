/*************************************************************************
 * tranSMART - translational medicine data mart
 * 
 * Copyright 2008-2012 Janssen Research & Development, LLC.
 * 
 * This product includes software developed at Janssen Research & Development, LLC.
 * 
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
 * as published by the Free Software  * Foundation, either version 3 of the License, or (at your option) any later version, along with the following terms:
 * 1.	You may convey a work based on this program in accordance with section 5, provided that you retain the above notices.
 * 2.	You may convey verbatim copies of this program code as you receive it, in any medium, provided that you retain the above notices.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS    * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 *
 ******************************************************************/
  
import bio.BioDataExternalCode
import search.SearchKeyword
import search.SearchKeywordTerm
import search.GeneSignature

/**
 * @author $Author: mmcduffie $
 * $Id: SearchKeywordService.groovy 9178 2011-08-24 13:50:06Z mmcduffie $
 * $Revision: 9178 $
 *
 */
public class SearchKeywordService {

	def springSecurityService
	
	// probably not needed but makes all methods transactional
	static transactional = true

	/** Finds all of the search categories pertaining to search keywords */
	def findSearchCategories()	{
		log.info "Finding all of the search categories..."
		
		def c = SearchKeyword.createCriteria()
		def results = c.list	{
			projections {
				distinct("dataCategory")
			}
			order("dataCategory", "asc")
		}
		
		log.info("Categories found: " + results.size())
		
		def categories = []
		
		for (result in results)	{
			categories.add(["category":result])
		}
		
		return categories
	}
	
	/** Searches for all keywords for a given term (like %il%) */
	def findSearchKeywords(category, term)	{
		log.info "Finding matches for ${term} in ${category}"
		
		def user = AuthUser.findByUsername(springSecurityService.getPrincipal().username)
		
		def c = SearchKeywordTerm.createCriteria()
		def results = c.list 	{
			if (term.size() > 0)	{
				ilike("keywordTerm", '%' + term + '%')
			}
			if ("ALL".compareToIgnoreCase(category) != 0)	{
				searchKeyword	{
					eq("dataCategory", category, [ignoreCase: true])
				}
			}
			if (!user.isAdmin())	{
				log.info("User is not an admin so filter out gene lists or signatures that are not public")
				or	{
					isNull("ownerAuthUserId")
					eq("ownerAuthUserId", user.id)
				}
			}
			maxResults(20)
			order("rank", "asc")
			order("termLength", "asc")
			order("keywordTerm", "asc")
		}
		log.info("Search keywords found: " + results.size())
		
		def keywords = []
		def dupeList = []			// store category:keyword for a duplicate check until DB is cleaned up
		
		for (result in results)	{
			def m = [:]
			def sk = result
			//////////////////////////////////////////////////////////////////////////////////
			// HACK:  Duplicate check until DB is cleaned up
			def dupeKey = sk.searchKeyword.displayDataCategory + ":" +sk.searchKeyword.keyword
			if (dupeKey in dupeList)	{
				log.info "Found duplicate: " + dupeKey
				continue
			} else	{
				log.info "Found new entry, adding to the list: " + dupeList
				dupeList << dupeKey
			}
			///////////////////////////////////////////////////////////////////////////////////
			m.put("label", sk.searchKeyword.keyword)
			m.put("id", , sk.searchKeyword.id)
			m.put("category", sk.searchKeyword.displayDataCategory)
			m.put("categoryId", sk.searchKeyword.dataCategory)
			if ("TEXT".compareToIgnoreCase(sk.searchKeyword.dataCategory) != 0)	{
				def synonyms = BioDataExternalCode.findAllWhere(bioDataId: sk.searchKeyword.bioDataId, codeType: "SYNONYM")
				def synList = new StringBuilder()
				for (synonym in synonyms)	{
					if (synList.size() > 0)	{
						synList.append(", ")
					} else	{
						synList.append("(")
					}
					synList.append(synonym.code)
				}
				if (synList.size() > 0)	{
					synList.append(")")
				}
				m.put("synonyms", synList.toString())
			}
			keywords.add(m)
		}
		return keywords
	 }


	/**
	 * convert pathways to a list of genes
	 */
	def expandPathwayToGenes(pathwayIds){
		return expandPathwayToGenes(pathwayIds, null)
	}

	/**
	 * convert pathways to a list of genes
	 */
	def expandPathwayToGenes(pathwayIds, Long max){
		if(pathwayIds==null || pathwayIds.length()==0){
			return []
		}
		def query = "select DISTINCT k from search.SearchKeyword k, bio.BioDataCorrelation c where k.bioDataId=c.associatedBioDataId and c.bioDataId in (" + pathwayIds + ") ORDER BY k.keyword"
		if(max!=null)
			return SearchKeyword.executeQuery(query, [max:max])
		else
			return SearchKeyword.executeQuery(query)


	}

	def expandAllListToGenes(pathwayIds){
		return expandAllListToGenes(pathwayIds, null);
	}

	def expandAllListToGenes(pathwayIds, Long max){
		if(pathwayIds==null || pathwayIds.length()==0){
			return []
		}
		def result = [];
		// find pathways
		def query = "select DISTINCT k from search.SearchKeyword k, bio.BioDataCorrelation c where k.bioDataId=c.associatedBioDataId and c.bioDataId in (" + pathwayIds + ") ORDER BY k.keyword"
		// find gene sigs
		def query2 = "select DISTINCT k from search.SearchKeyword k, search.SearchBioMarkerCorrelFastMV c where k.bioDataId=c.assocBioMarkerId and c.domainObjectId in (" + pathwayIds + ") ORDER BY k.keyword"
		if(max!=null)
			result.addAll(SearchKeyword.executeQuery(query, [max:max]))
			if(result.size()<max){
				result.addAll(SearchKeyword.executeQuery(query2,[max:(max-result.size())]));
			}
		else{
			result.addAll(SearchKeyword.executeQuery(query));
			result.addAll(SearchKeyword.executeQuery(query2));
		}
			return result;

	}

	/**
	 * link a GeneSignature new instance to search
	 */
	def newGeneSignatureLink(GeneSignature gs, boolean bFlush) {
		// link  gs to search
		SearchKeyword keyword = createSearchKeywordFromGeneSig(gs)

		keyword.validate()
		println("keyword validate()")

		if(keyword.hasErrors()){
			println("WARN: SearchKeyword validation error!")
			keyword.errors.each { println it }
		}
		println("INFO: saving new SearchKeyword!")
		keyword.save(flush: bFlush)
	}

	/**
	 * update GeneSignature/List link to search
	 */
	def updateGeneSignatureLink(GeneSignature gs, String domainKey, boolean bFlush) {
		// find keyword record
		SearchKeyword keyword = SearchKeyword.findByBioDataIdAndDataCategory(gs.id, domainKey)
		println("INFO: retrieved "+keyword)

		// delete search keywords
		if(gs.deletedFlag || (domainKey==GeneSignature.DOMAIN_KEY_GL && gs.foldChgMetricConceptCode.bioConceptCode=='NOT_USED')) {
			if(keyword!=null) keyword.delete(flush: bFlush)
		} else {
			// add if does not exist
			if(keyword==null) {
				keyword = createSearchKeywordFromGeneSig(gs, domainKey)
			} else {
				// update keyword
				keyword.keyword = gs.name
				keyword.ownerAuthUserId = gs.publicFlag ? null : gs.createdByAuthUser.id
				keyword.terms.each {
					println("INFO: "+it)
					it.keywordTerm = gs.name.toUpperCase()
					it.ownerAuthUserId = gs.publicFlag ? null : gs.createdByAuthUser.id
					//println("INFO: setting owner to: "+it.ownerAuthUserId)
				}
			}

			keyword.validate()
			if(keyword.hasErrors()){
				println("WARN: SearchKeyword validation error!")
				keyword.errors.each { println it }
			}
			println("INFO: trying to save SearchKeyword")
			keyword.save(flush: bFlush)
		}
	}

	/**
	 * create a new SearchKeyord for a GeneSignatute
	 */
	def createSearchKeywordFromGeneSig(GeneSignature gs, String domainKey) {
		println("INFO: creating SearchKeyword for GS: "+gs.name+ "["+domainKey+"]")

		// display category GS or GL?
		def displayName = (domainKey==GeneSignature.DOMAIN_KEY) ? GeneSignature.DISPLAY_TAG : GeneSignature.DISPLAY_TAG_GL
		def uniqueId = domainKey+":"+gs.id

		SearchKeyword keyword = new SearchKeyword()
		keyword.properties.keyword = gs.name
		keyword.properties.bioDataId = gs.id
		keyword.properties.uniqueId = uniqueId
		keyword.properties.dataCategory = domainKey
		keyword.properties.displayDataCategory = displayName
		keyword.properties.dataSource="Internal"
		if(!gs.publicFlag) keyword.properties.ownerAuthUserId = gs.createdByAuthUser?.id

		// keyword term
		SearchKeywordTerm term = new SearchKeywordTerm()
		term.properties.keywordTerm = gs.name.toUpperCase()
		term.properties.rank = 1
		term.properties.termLength = gs.name.length()
		if(!gs.publicFlag) term.properties.ownerAuthUserId = gs.createdByAuthUser?.id

		// associate term
		keyword.addToTerms(term)

		//println(keyword)
		//println("properties:\n"+keyword.properties)
		return keyword;
	}

}
