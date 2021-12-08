# data.R
# Author: Kai Ren Chen (kairen.chen@mail.utoronto.ca)
# Date: December 8, 2021

#' Protein Peptide Mappings in Character Vector
#'
#' A set of peptide obtained mass spectrometry, mapped to protein from uniprot
#' should be even
#'
#' @source 
#' https://github.com/OpenMS/OpenMS/blob/develop/share/OpenMS/examples/BSA/BSA1_OMSSA.idXML
#'
#' @format A character vector:
#' \describe{
#'   a peptide sequence, then a protein accession and so on 
#' }
#' @references Röst, H. L., Sachsenberg, T., Aiche, S., Bielow, C., Weisser, H.,
#'  Aicheler, F., Andreotti, S., Ehrlich, H. C., Gutenbrunner, P., Kenar, E.,
#'  Liang, X., Nahnsen, S., Nilse, L., Pfeuffer, J., Rosenberger, G.,
#'  Rurik, M., Schmitt, U., Veit, J., Walzer, M., Wojnar, D., …
#'  Kohlbacher, O. (2016). OpenMS: a flexible open-source software 
#'  platform for mass spectrometry data analysis. Nature methods, 13(9),
#'  741–748. https://doi.org/10.1038/nmeth.3959
#' @examples
#' \dontrun{
#'  allEdges
#' }
"allEdges"

#' Protein Peptide Mappings in IdXML File Format
#'
#' A set of peptides obtained mass spectrometry, mapped to proteins from uniprot.
#'
#' @source 
#' https://github.com/OpenMS/OpenMS/blob/develop/share/OpenMS/examples/BSA/BSA1_OMSSA.idXML
#'
#' @references Röst, H. L., Sachsenberg, T., Aiche, S., Bielow, C., Weisser, H.,
#'  Aicheler, F., Andreotti, S., Ehrlich, H. C., Gutenbrunner, P., Kenar, E.,
#'  Liang, X., Nahnsen, S., Nilse, L., Pfeuffer, J., Rosenberger, G.,
#'  Rurik, M., Schmitt, U., Veit, J., Walzer, M., Wojnar, D., …
#'  Kohlbacher, O. (2016). OpenMS: a flexible open-source software 
#'  platform for mass spectrometry data analysis. Nature methods, 13(9),
#'  741–748. https://doi.org/10.1038/nmeth.3959
#' @format idXML (see https://abibuilder.informatik.uni-tuebingen.de/archive/
#' openms/Documentation/nightly/html/classOpenMS_1_1IdXMLFile.html)
#' @name BSA1_OMSSA.idXML
NULL

#' Protein Peptide Mappings in OSW File Format
#' 
#' This is just a sample file, all of its components only have 1 protein, this
#' means that all peptide map to one protein only. And thus the inferred 
#' proteins is simply just all the proteins. Also these protein are not real
#' proteins (their "accession" does not correspond to an uniprot entry)
#'
#' @source 
#' https://github.com/PyProphet/pyprophet/blob/master/tests/data/test_data.osw
#'
#' @references Teleman, J., Röst, H. L., Rosenberger, G., Schmitt, U.,
#'  Malmström, L., Malmström, J., & Levander, F. (2015). 
#'  DIANA--algorithmic improvements for analysis of data-independent acquisition
#'  MS data. Bioinformatics (Oxford, England), 31(4), 555–562. 
#'  https://doi.org/10.1093/bioinformatics/btu686
#' @format transition PQP (see https://abibuilder.informatik.uni-tuebingen.de/
#' archive/openms/Documentation/release/2.6.0/html/
#' classOpenMS_1_1TransitionPQPFile.html) for file format description
#' @name test_data.osw
NULL

# [END]