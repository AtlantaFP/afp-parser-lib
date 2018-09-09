(asdf:defsystem #:afp-parser-lib
  :description "Atlanta Functional Programming parsing library"
  :author ("Michael Fiano <mail@michaelfiano.com>")
  :license "MIT"
  :version "0.1.0"
  :depends-on (#:afp-utils
               #:bitio
               #:babel
               #:fast-io)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "buffer")
   (:file "readers")))
