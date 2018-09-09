(in-package :afp-parser-lib)

(defvar *buffer-manager*)

(defclass buffer-manager ()
  ((bytes :reader bytes
          :initarg :bytes)
   (bits :reader bits
         :initarg :bits)
   (stream :reader buffer-stream
           :initarg :stream)))

(defun buffer-position ()
  (fast-io:buffer-position (bytes *buffer-manager*)))

(defmacro with-buffer ((&key sequence stream) &body body)
  (afp-utils:with-unique-names (bytes bits)
    `(let* ((,bytes (fast-io:make-input-buffer :vector ,sequence
                                               :stream ,stream))
            (,bits (bitio:make-bitio ,bytes
                                     #'fast-io:fast-read-byte
                                     (lambda (sequence buffer &key (start 0) end)
                                       (fast-io:fast-read-sequence sequence buffer start end))))
            (*buffer-manager* (make-instance 'buffer-manager
                                             :bytes ,bytes
                                             :bits ,bits
                                             :stream (fast-io:input-buffer-stream ,bytes))))
       ,@body)))
