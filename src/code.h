// #include <Rcpp.h>
// using namespace Rcpp;

// --------------------------------------------------------------------------
//                   OpenMS -- Open-Source Mass Spectrometry
// --------------------------------------------------------------------------
// Copyright The OpenMS Team -- Eberhard Karls University Tuebingen,
// ETH Zurich, and Freie Universitaet Berlin 2002-2021.
//
// This software is released under a three-clause BSD license:
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//  * Neither the name of any author or any participating institution
//    may be used to endorse or promote products derived from this software
//    without specific prior written permission.
// For a full list of authors, refer to the file AUTHORS.
// --------------------------------------------------------------------------
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL ANY OF THE AUTHORS OR THE CONTRIBUTING
// INSTITUTIONS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// --------------------------------------------------------------------------
// $Maintainer: Timo Sachsenberg $
// $Authors: Marc Sturm $
// --------------------------------------------------------------------------

// #pragma once
// 
// #include "types.h"
// 
// #include <vector>
// 
// namespace OpenMS
// {
//   namespace Internal
//   {
//     class FeatureXMLHandler;
//     class ConsensusXMLHandler;
//   }
//   /**
//    @brief Used to load and store idXML files
//    
//    This class is used to load and store documents that implement
//    the schema of idXML files.
//    
//    A documented schema for this format can be found at https://github.com/OpenMS/OpenMS/tree/develop/share/OpenMS/SCHEMAS
//    
//    One file can contain several ProteinIdentification runs. Each run consists of peptide hits stored in
//    PeptideIdentification and (optional) protein hits stored in Identification. Peptide and protein
//    hits are connected via a string identifier. We use the search engine and the date as identifier.
//    
//    @note This format will eventually be replaced by the HUPO-PSI (mzIdentML and mzQuantML)) AnalysisXML formats!
//    
//    @ingroup FileIO
//    */
//   class OPENMS_DLLAPI IdXMLFile:
//     protected Internal::XMLHandler,
//     public Internal::XMLFile,
//     public ProgressLogger
//   {
//   public:
//     // both ConsensusXMLFile and FeatureXMLFile use some protected IdXML helper functions to parse identifications without code duplication
//     friend class Internal::ConsensusXMLHandler;
//     friend class Internal::FeatureXMLHandler;
//     
//     /// Constructor
//     IdXMLFile();
//     
//     /**
//      @brief Loads the identifications of an idXML file without identifier
//      
//      The information is read in and the information is stored in the
//      corresponding variables
//      
//      @exception Exception::FileNotFound is thrown if the file could not be opened
//      @exception Exception::ParseError is thrown if an error occurs during parsing
//      */
//     void load(const String& filename, std::vector<ProteinIdentification>& protein_ids, std::vector<PeptideIdentification>& peptide_ids);
//     
//     /**
//      @brief Loads the identifications of an idXML file
//      
//      The information is read in and the information is stored in the
//      corresponding variables
//      
//      @exception Exception::FileNotFound is thrown if the file could not be opened
//      @exception Exception::ParseError is thrown if an error occurs during parsing
//      */
//     void load(const String& filename, std::vector<ProteinIdentification>& protein_ids, std::vector<PeptideIdentification>& peptide_ids, String& document_id);
// 
//     
//     
//   protected:
//     
//     /// @name members for loading data
//     //@{
//     /// Pointer to fill in protein identifications
//     std::vector<ProteinIdentification>* prot_ids_;
//     /// Pointer to fill in peptide identifications
//     std::vector<PeptideIdentification>* pep_ids_;
//     /// Pointer to last read object with MetaInfoInterface
//     MetaInfoInterface* last_meta_;
//     /// Search parameters map (key is the "id")
//     std::map<String, ProteinIdentification::SearchParameters> parameters_;
//     /// Temporary search parameters variable
//     ProteinIdentification::SearchParameters param_;
//     /// Temporary id
//     String id_;
//     /// Temporary protein ProteinIdentification
//     ProteinIdentification prot_id_;
//     /// Temporary peptide ProteinIdentification
//     PeptideIdentification pep_id_;
//     /// Temporary protein hit
//     ProteinHit prot_hit_;
//     /// Temporary peptide hit
//     PeptideHit pep_hit_;
//     /// Temporary analysis result instance
//     PeptideHit::PepXMLAnalysisResult current_analysis_result_;
//     /// Temporary peptide evidences
//     std::vector<PeptideEvidence> peptide_evidences_;
//     /// Map from protein id to accession
//     std::unordered_map<std::string, String> proteinid_to_accession_;
//     /// Document identifier
//     String* document_id_;
//     /// true if a prot id is contained in the current run
//     bool prot_id_in_run_;
//     //@}
//   };
// 
// } // namespace OpenMS
