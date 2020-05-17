#!/bin/bash

validate_fields(){
    if [ -z $EMAIL ]
            then
                EMAIL=$(yad --form\
                            --title="Email não prenchido"\
                            --width=300\
                            --height=100\
                            --field="Digite o Email:"\
                            --button=gtk-ok:0\
                            --center)

            fi

    if [ -z $PASS ]
        then
            PASS=$(yad --form\
                            --title="Senha não preenchida"\
                            --width=300\
                            --height=100\
                            --field="Digite a senha:":H\
                            --button=gtk-ok:0\
                            --center)
                            send_email;

        else
            send_email;
        fi

}


send_email(){
    if [ -z $ANEX ]
    then
        echo "${CONTEUDO}" | mutt -s "$SUBJECT" "$DEST"

        
    else
        echo "${CONTEUDO}" | mutt -s "$SUBJECT" -a "$ANEX" -- $DEST
    fi
}

form_email(){
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
            --field="Conteudo:TXT"""\
            --field="Destinatario:"""\
            --filed="Nome:"""\
            --field="Anexo:":FL""\
            --center \
    )
    if [ $? -eq 1 ]
    then
        yad --title="Saindo do programa..."\
        --text="Espero que tenha gostado da utilização ^^"\
        --width="400"\
        --height="100"\
        --button=gtk-ok:0\
        --center
        exit;
    else

        echo $var_form
        EMAIL=$(echo ${var_form}| cut -d"|" -f3)
        echo "Email: ${EMAIL}"
        PASS=$(echo ${var_form}| cut -d"|" -f4)
        SUBJECT=$(echo ${var_form}| cut -d"|" -f5)
        echo "Assunto: ${SUBJECT}"
        PROVEDOR=$(echo ${var_form}| cut -d"|" -f2)
        echo "Provedor: ${PROVEDOR}"
        CONTEUDO=$(echo ${var_form}| cut -d"|" -f6)
        echo "Conteudo: ${CONTEUDO}"
        DEST=$(echo ${var_form}| cut -d"|" -f7)
        echo "Destinatario: ${DEST}"
        ANEX=$(echo ${var_form}| cut -d"|" -f8)
        echo "Anexo: ${ANEX}"




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
        ;;
        'HOTMAIL')
            yad --title="Hotmail Info"\
            --text="Ainda não temos essa função :c"\
            --width="300"\
            --height="100"\
            --button=gtk-ok:0\
            --center
            exit;
        ;;
       

        esac
        validate_fields;
    fi
   
}

form_email;

