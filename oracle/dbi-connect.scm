(use dbi)

(define conn (dbi-connect "dbi:oracle://192.168.0.33" :username "hr" :password "hr"))
