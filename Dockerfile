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

# Skripte kopieren
COPY convert_latex_to_pdf.sh /usr/local/bin/convert_latex_to_pdf.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Skript ausführbar machen
RUN chmod +x /usr/local/bin/convert_latex_to_pdf.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

# Standard-Eintragspunkt definieren
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Standard-Argumente (wenn keine übergeben werden)
CMD ["convert_latex_to_pdf.sh", "example.tex"]