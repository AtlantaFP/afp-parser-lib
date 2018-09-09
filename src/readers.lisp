(in-package :afp-parser-lib)

(defun read-bits (count)
  (bitio:read-bits (bits *buffer-manager*) count))

(defun read-bytes (count &key (bits-per-byte 8))
  (let ((octets (fast-io:make-octet-vector count)))
    (bitio:read-bytes (bits *buffer-manager*) octets :bits-per-byte bits-per-byte)
    octets))

(defun read-int-le (byte-count &key (bits-per-byte 8))
  (bitio:read-integer (bits *buffer-manager*)
                      :byte-endian :le
                      :num-bytes byte-count
                      :bits-per-byte bits-per-byte
                      :unsignedp nil))

(defun read-int-be (byte-count &key (bits-per-byte 8))
  (bitio:read-integer (bits *buffer-manager*)
                      :byte-endian :be
                      :num-bytes byte-count
                      :bits-per-byte bits-per-byte
                      :unsignedp nil))

(defun read-uint-le (byte-count &key (bits-per-byte 8))
  (bitio:read-integer (bits *buffer-manager*)
                      :byte-endian :le
                      :num-bytes byte-count
                      :bits-per-byte bits-per-byte
                      :unsignedp t))

(defun read-uint-be (byte-count &key (bits-per-byte 8))
  (bitio:read-integer (bits *buffer-manager*)
                      :byte-endian :be
                      :num-bytes byte-count
                      :bits-per-byte bits-per-byte
                      :unsignedp t))

(defun string-length (byte-count null-terminated-p)
  (let* ((sequence (fast-io:input-buffer-vector (bytes *buffer-manager*)))
         (max-length (or byte-count (length sequence)))
         (start (buffer-position))
         (end (min (length sequence) (+ start max-length)))
         (index (if null-terminated-p
                    (position #x0 sequence :start start :end end)
                    end)))
    (- index start)))

(defun read-string (&key byte-count (encoding :ascii) null-terminated-p (processor #'identity))
  (let ((octets (read-bytes (string-length byte-count null-terminated-p))))
    (when null-terminated-p
      (read-bytes 1))
    (babel:octets-to-string (funcall processor octets) :encoding encoding)))
