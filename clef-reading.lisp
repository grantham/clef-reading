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
;;;; clef-reading
;;;;
;;;; This system depends on Common Music Notation (CMN), see:
;;;;  https://ccrma.stanford.edu/software/cmn/cmn/cmn.html
;;;;
;;;; *************************************************************************

(defpackage :clef-reading
  (:use :cl :cmn)
  (:export :make-reading))

(in-package :clef-reading)
(in-package :cmn)

(defvar *clefs* (list soprano alto cmn::tenor))

(defun soprano-notes (&key type)
  (cond
    ((equal :diatonic type)
     (list a3 b3 c4 d4 e4 f4 g4 a4 b4 c5 d5 e5 f5 g5))
    ((equal :lines type)
     (list a3 c4 e4 g4 b4 d5 f5))
    ((equal :spaces type)
     (list g3 b3 d4 f4 a4 c5 e5 g5))
    (t 
     (list gf3 g3 gs3 af3 a3 as3 bf3 b3 bs3
	   cf4 c4 cs4 df4 d4 ds4 ef4 e4 es4 ff4 f4 fs4 gf4 g4 gs4 af4 a4 as4 bf4 b4 bs4
	   cf5 c5 cs5 df5 d5 ds5 ef5 e5 es5 ff5 f5 fs5 gf5 g5 gs5 af5 a5 as5 bf5 b5 bs5))))

(defun alto-notes (&key type)
  (cond
    ((equal :diatonic type)
     (list c3 d3 e3 f3 g3 a3 b3 c4 d4 e4 f4 g4 a4 b4 c5))
    ((equal :lines type)
     (list d3 f3 a3 c4 e4 g4 b4))
    ((equal :spaces type)
     (list c3 e3 g3 b3 d4 f4 a4 c5))
    (t
     (list cf3 c3 cs3 df3 d3 ds3 ef3 e3 es3 ff3 f3 fs3 gf3 g3 gs3 af3 a3 as3 bf3 b3 bs3
	   cf4 c4 cs4 df4 d4 ds4 ef4 e4 es4 ff4 f4 fs4 gf4 g4 gs4 af4 a4 as4 bf4 b4 bs4
	   cf5 c5 cs5))))

(defun tenor-notes (&key type)
  (cond
    ((equal :diatonic type)
     (list a2 b2 c3 d3 e3 f3 g3 a3 b3 c4 d4 e4 f4 g4 a4))
    ((equal :lines type)
     (list b2 d3 f3 a3 c4 e4 g4 b4))
    ((equal :spaces type)
     (list a2 c3 e3 g3 b3 d4 f4 a4 c5))
    (t
     (list gf2 g2 gs2 af2 a2 as2 bf2 b2 bs2
	   cf3 c3 cs3 df3 d3 ds3 ef3 e3 es3 ff3 f3 fs3 gf3 g3 gs3 af3 a3 as3 bf3 b3 bs3
	   cf4 c4 cs4 df4 d4 ds4 ef4 e4 es4 ff4 f4 fs4 gf4 g4 gs4 af4 a4 as4))))

(defun lines-and-spaces (&key clef)
  (cond
    ((equal soprano clef)
     (engorge 
      (list soprano a3 w c4 w e4 w g4 w b4 w d5 w f5 w g3 w b3 w d4 w f4 w a4 w c5 w e5 w g5 w)))
    ((equal alto clef)
     (engorge 
      (list alto d3 w f3 w a3 w c4 w e4 w g4 w b4 w c3 w e3 w g3 w b3 w d4 w f4 w a4 w c5 w)))
    ((equal tenor clef)
     (engorge 
      (list tenor b2 w d3 w f3 w a3 w c4 w e4 w g4 w b4 w a2 w c3 w e3 w g3 w b3 w d4 w f4 w a4 w c5 w)))))

(defun note-source (&key clef type)
  "type is one of :chromatic :diatonic :lines :spaces"
  (cond
    ((equal soprano clef)
     (soprano-notes :type type))
    ((equal alto clef)
     (alto-notes :type type))
    ((equal tenor clef)
     (tenor-notes :type type))))

(defun random-elt (lst)
  (nth (random (- (length lst) 1)) lst))

(defun random-note (&key type (use-clef nil))
  (let ((clef (if use-clef use-clef (random-elt *clefs*))))
    (cond 
      ((equal soprano clef)
       (list soprano (random-elt (soprano-notes :type type)) w))
      ((equal alto clef)
       (list alto (random-elt (alto-notes :type type)) w))
      ((equal tenor clef)
       (list tenor (random-elt (tenor-notes :type type)) w))
      (t (error "what the hell just happened?")))))

(defun collect-notes (how-many &key type use-clef (show-clef t))
  (engorge
   (mapcan 
    (lambda (x) 
      (if show-clef 
	  (random-note :type type :use-clef use-clef)
	  (cdr (random-note :type type :use-clef use-clef))))
      (loop for i upto how-many collect i))))

(defun clef-to-string (clef)
  (symbol-name (clef-name soprano)))

;;(make-reading (* 6 80) :clef soprano :file-name "soprano-reading.ps")
(defun make-reading (n &key clef (file-name "clef-reading.ps"))
  "Makes a clef-reading exercise for the specified clef (on of soprano
alto tenor) with n elements for line, space, diatonic, and chromatic
reading."
  (cmn
   (output-type :postscript)
   (output-file file-name)
   (all-output-in-one-file t)
   (title (concatenate 'string (clef-to-string clef) " CLEF READING PRACTICE"))
   (size 20) staff (meter alla-breve)
   (lines-and-spaces :clef clef)
   line-mark 
   (collect-notes n :type :lines :use-clef clef :show-clef nil)
   line-mark 
   (collect-notes n :type :spaces :use-clef clef :show-clef nil)
   line-mark 
   (collect-notes n :type :diatonic :use-clef clef :show-clef nil)
   line-mark
   (collect-notes n :type :chromatic :use-clef clef :show-clef nil)
   double-bar))
