;; ymd-emacs-osx-open: Open URI in the active region or at the cursor position by OS X open command
;;
;; Copyright 2015 Hiroyuki Yamada
;;
;; This is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this.  If not, see <http://www.gnu.org/licenses/>.
;;

(defun osx-open (URI)
  "Open URI by OS X open command

If region is active, the region is used as default input,
otherwise url or file at the cursor position is used as default
input. Input uri is passed to OS X open command, so it is also
possible to include option flag in it."
  (interactive
   (let ((local-uri (or (and (use-region-p) (buffer-substring (region-beginning) (region-end)))
			(thing-at-point 'url)
			(thing-at-point 'file)))
	 (enable-recursive-minibuffers t))
     (setq local-uri (read-string (if local-uri (format "Open (default %s): " local-uri) "Open: ") nil nil local-uri))
     (list local-uri)))
  (if (string= URI "")
      (message "You did not specify URI to open.")
    (shell-command (concat "/usr/bin/open " URI))))
