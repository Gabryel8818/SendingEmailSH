#!/bin/bash
HOJE=$(date +%d/%m/%Y)
echo > ~/.muttrc
var_form=$(
    yad --form\
        --title="Envio de Email :)"\
        --width=400\
        --height=400\
        --image-"acessories-text-editor"\
        --field="Enviando email em":RO "$HOJE"\
        --field="Provedor:":CB GMAIL!HOTMAIL\
        --field="Email:"""\
        --field="Senha:":H""\
        ---field="Assunto:"""\
        --field="Conteudo:"""\
        --field="Destinatario:"""\
        --filed="Nome:"""\
        --field="Anexo:":FL""\
        --center
)

echo $var_form
EMAIL=$(echo ${var_form}| cut -d"|" -f3)
echo "Email: ${EMAIL}"
SUBJECT=$(echo ${var_form}| cut -d"|" -f5)
echo "Assunto: ${SUBJECT}"
PROVEDOR=$(echo ${var_form}| cut -d"|" -f2)
echo "Provedor: ${PROVEDOR}"
CONTEUDO=$(echo ${var_form}| cut -d"|" -f6)
echo "Conteudo: ${CONTEUDO}"
DEST=$(echo ${var_form}| cut -d"|" -f7)
echo "Destinatario: ${DEST}"

case $PROVEDOR in
'GMAIL')
    echo "set ssl_starttls="yes" " >> ~/.muttrc
    echo "set ssl_force_tls="yes" " >> ~/.muttrc
    echo "set imap_user="${EMAIL}" " >> ~/.muttrc 
    echo "set imap_pass="${PASS}" " >> ~/.muttrc 
    echo "set from="${EMAIL}" " >> ~/.muttrc 
    set realname="${NAME}" >> ~/.muttrc 
    echo "set folder="imaps://imap.gmail.com/" " >> ~/.muttrc  
    echo "set spoolfile="imaps://imap.gmail.com/INBOX" " >> ~/.muttrc 
    echo "set postponed="imaps://imap.gmail.com/[Gmail]/Drafts" " >> ~/.muttrc 
    echo "set smtp_url="smtps://${EMAIL}:${PASS}@smtp.gmail.com:465/" " >> ~/.muttrc 
    echo "set move="no" " >> ~/.muttrc 
    echo "set imap_keepalive="900" " >> ~/.muttrc 
    echo "${CONTEUDO}" | mutt -s "$SUBJECT" "$DEST"

;;
 'HOTMAIL')
    yad --title="Hotmail Info"\
    --text="Ainda não temos essa função :c"\
    --width="300"\
    --height="100"\
    --center
;;
esac
