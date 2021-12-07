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

// #include "code.h"
// 
// #include <fstream>
// #include <unordered_map>
// 
// using namespace std;
// 
// namespace OpenMS
// {
// 
//   IdXMLFile::IdXMLFile() :
//     XMLHandler("", "1.5"),
//     XMLFile("/SCHEMAS/IdXML_1_5.xsd", "1.5"),
//     last_meta_(nullptr),
//     document_id_(),
//     prot_id_in_run_(false)
//   {
//   }
//   
//   void IdXMLFile::load(const String& filename, std::vector<ProteinIdentification>& protein_ids, std::vector<PeptideIdentification>& peptide_ids)
//   {
//     String document_id;
//     load(filename, protein_ids, peptide_ids, document_id);
//   }
//   
//   void IdXMLFile::load(const String& filename, std::vector<ProteinIdentification>& protein_ids,
//                        std::vector<PeptideIdentification>& peptide_ids, String& document_id)
//   {
//     startProgress(0, 0, "Loading idXML");
//     //Filename for error messages in XMLHandler
//     file_ = filename;
//     
//     protein_ids.clear();
//     peptide_ids.clear();
//     
//     prot_ids_ = &protein_ids;
//     pep_ids_ = &peptide_ids;
//     document_id_ = &document_id;
//     
//     parse_(filename, this);
//     
//     //reset members
//     prot_ids_ = nullptr;
//     pep_ids_ = nullptr;
//     last_meta_ = nullptr;
//     parameters_.clear();
//     param_ = ProteinIdentification::SearchParameters();
//     id_ = "";
//     prot_id_ = ProteinIdentification();
//     pep_id_ = PeptideIdentification();
//     prot_hit_ = ProteinHit();
//     pep_hit_ = PeptideHit();
//     proteinid_to_accession_.clear();
//     
//     endProgress();
//   }
// 
// } // namespace OpenMS