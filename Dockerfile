FROM alpine:latest

# Repositories aktualisieren
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.10/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.10/community" >> /etc/apk/repositories

# Installiere bash, texlive, biber und Bereinigung von Cache
RUN apk update && \
    apk add --no-cache \
    bash \
    texmf-dist \
    texlive \
    texlive-full \
    biber && \
    rm -rf /var/cache/apk/*

# Erstelle den Benutzer jenkins mit uid 1000, gid 1000 und Home-Verzeichnis /home/jenkins
RUN adduser -D -h /home/jenkins -s /bin/bash -u 1000 -g 1000 jenkins

# Gib jenkins Benutzer Schreibrechte auf sein Home-Verzeichnis
RUN chown -R 1000:1000 /home/jenkins

# Skripte kopieren
COPY convert_latex_to_pdf.sh /usr/local/bin/convert_latex_to_pdf.sh

# Skript ausführbar machen
RUN chmod +x /usr/local/bin/convert_latex_to_pdf.sh

# Den Benutzer auf jenkins setzen, um die Befehle auszuführen
USER jenkins
