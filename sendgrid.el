;;; sendgrid.el --- Sendgrid Client Library

;; Copyright (C) 2015 Daniel Bordak

;; Author: Daniel Bordak <dbordak@fastmail.fm>
;; URL: TODO
;; Version: 0.1
;; Package-Requires: ((request "0.2"))

;;; Commentary:
;;
;; todo maybe if i feel like it
;;

;;; Code:

(require 'cl-lib)
(require 'request)

(defgroup sendgrid nil
  "Sendgrid client library"
  :prefix "sendgrid-")

(defconst sendgrid-base-url "https://api.sendgrid.com/api")

(defcustom sendgrid-address nil
  "The address to send emails from."
  :group 'sendgrid
  :type 'string)

(defcustom sendgrid-username nil
  "The username to use if not specified."
  :group 'sendgrid
  :type 'string)

(defcustom sendgrid-password nil
  "The password to use if not specified."
  :group 'sendgrid
  :type 'string)

(cl-defun sendgrid-send-message (to message
                                    &key
                                    (from sendgrid-address)
                                    (user sendgrid-username)
                                    (pass sendgrid-password))
  "Send MESSAGE from FROM as an email to TO.
Uses USER if given, otherwise uses sendgrid-username.
If no MESSAGE is given, sends the current buffer."
  (request
   (concat sendgrid-base-url "/mail.send.json")
   :type "POST"
   :parser 'json-read
   :data `(("to" . ,to)
           ("from" . ,from)
           ("subject" . "test")
           ("api_user" . ,user)
           ("api_key" . ,pass)
           ("text" . ,message))))

(provide 'sendgrid)

;;; sendgrid.el ends here
