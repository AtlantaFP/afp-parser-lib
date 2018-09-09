(defpackage #:afp-parser-lib
  (:use #:cl)
  (:export #:with-buffer
           #:read-bits
           #:read-bytes
           #:read-int-be
           #:read-int-le
           #:read-uint-be
           #:read-uint-le
           #:read-string))
