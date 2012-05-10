<p>
	<font color='red'>
		${warningMsg}
	</font>
</p>
<table class="searchform">
	<g:each in="${snpDatasets}" status="i" var="snpSubset">
		<tr>
			<td style='white-space: nowrap'>SNP Datasets in Subset ${snpSubset.key}:</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>
			${snpSubset.value}
			</td>
		</tr>
	</g:each>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign='top' style='white-space: nowrap'>Select Chromosomes:</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td><g:select name="gwasChroms" id="gwasChroms" from="${chroms}"
				value="${chromDefault}" multiple="multiple" size="5"></g:select></td>
</table>