;;;; -*- Mode: Lisp;  -*-
;;;; *************************************************************************
;;;; Copyright (C) 2012 Roger Grantham
;;;; 
;;;; All rights reserved.
;;;; 
;;;; This file is part of clef-reading.
;;;; 
;;;; clef-reading is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by 
;;;; the Free Software Foundation, either version 3 of the License, or    
;;;; (at your option) any later version.                                  
;;;; 
;;;; clef-reading is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;; 
;;;; You should have received a copy of the GNU General Public License
;;;; along with clef-reading.  If not, see <http://www.gnu.org/licenses/>.
;;;; 
;;;; *************************************************************************
;;;;
;;;; clef-reading System Definition 
;;;;
;;;; This system depends on Common Music Notation (CMN), see:
;;;;  https://ccrma.stanford.edu/software/cmn/cmn/cmn.html
;;;;
;;;; *************************************************************************

(in-package :common-lisp-user)
(require :asdf)
(asdf:operate 'asdf:load-source-op 'cmn)

(asdf:defsystem :clef-reading
  :name "clef-reading"
  :author "Roger Grantham <grantham@member.fsf.org>"
  :version "0.9.0"
  :maintainer "Roger Grantham <grantham@member.fsf.org>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3"
  :description "Generates C clef reading exercises as postscript files."
  :long-description ""
  :depends-on (:cmn)
  :components ((:file "clef-reading")))
     
(in-package :cmn)