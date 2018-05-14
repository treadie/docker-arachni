#!/bin/bash
# Arachni Web Bootstrap

logo() {
    cat <<FILE
[32m
     ▄▄▄· ▄▄▄   ▄▄▄·  ▄▄·  ▄ .▄ ▐ ▄ ▪      .▄▄ ·  ▄▄·  ▄▄▄·  ▐ ▄  ▐ ▄ ▄▄▄ .▄▄▄
     ▐█ ▀█ ▀▄ █·▐█ ▀█ ▐█ ▌▪██▪▐█•█▌▐███     ▐█ ▀. ▐█ ▌▪▐█ ▀█ •█▌▐█•█▌▐█▀▄.▀·▀▄ █·
     ▄█▀▀█ ▐▀▀▄ ▄█▀▀█ ██ ▄▄██▀▐█▐█▐▐▌▐█·    ▄▀▀▀█▄██ ▄▄▄█▀▀█ ▐█▐▐▌▐█▐▐▌▐▀▀▪▄▐▀▀▄
     ▐█ ▪▐▌▐█•█▌▐█ ▪▐▌▐███▌██▌▐▀██▐█▌▐█▌    ▐█▄▪▐█▐███▌▐█ ▪▐▌██▐█▌██▐█▌▐█▄▄▌▐█•█▌
      ▀  ▀ .▀  ▀ ▀  ▀ ·▀▀▀ ▀▀▀ ·▀▀ █▪▀▀▀     ▀▀▀▀ ·▀▀▀  ▀  ▀ ▀▀ █▪▀▀ █▪ ▀▀▀ .▀  ▀
[0m
FILE
}

picture() {
    cat <<TEXT
[31m

                                               I     III
                                      III    IHNN    NNCH
                                 IINHHHHHN   HCHN   IHNICN
                             INNNNII    NHNIICIHHI  NHN NNIINNNNNNNNNII
                           NHNII         IHNICIHHI  NHIINHNNNNNNNNNNHHHHHNI
                           HN             IHNH HHN  HHIHHNNNNNNNNNHHHNNNHHHHHNNI
                         IIHHNII           IHNIHCHIIHHHHHHHHNNNNNHHHNNNNNNHIINNHCHHNI
                   IINNHHNNHNNHHHHNNII      CCHNCCNNHHHHHHCHNNNHHCNNHHHCCHHI     INNHHNI
               IINNNNNI   ICI    IINNHHHNNNNHHCNHHNHHHHHNNHHCHHHHHCCCCCCHHHHHI        HCI
             INNII        ICI          INNHHCCCCCCACHNHHHHHHCHHCCHHHNIII    NHHN       HN
            NHI           IH             INNHCCHHHCHNHCCHHCHHCHN              IHCNI    ICN
           NN             NN             NCHAACHHHHHHCCHHCHHHHIIIIIIIII         IHCN    NH
         IHN             IHI             HNHCCHAAHHCCCHNNNINHCHHHHHHHHNNII        IHI    HI
        IHI             IHNIII             HHHHHI IIINNNHHHCCCCHCCHHHHHNNII        NHI   IC
      INN               III               IHNIIIINNHHHCCCCCCCCCCHHHHNNNII           HN    HN
    NNNI                                 NHHINNNHHCCCCCCCCCHHHHHNIIIII              IHN    NH
                                        NHHNHHHHCCCCCHHHHHNNIINCN                    NH   IINHI
                                       ICHNNHHHHHHHHNNNIIIII  IHN                     HN    INNI
                                       HHIINNNNNNNII           HN                     IH
                                      ICI                    IINH                     IHN
                                      NN                      IICI                     IHN
                                      HNI                      IHN                       IN
                                     NHN                        IH
                                    IHN                          NN
                                   IHN                            I
                                  INI
[0m
TEXT
}

genpass() {
    cat /dev/urandom | tr -cd 'A-Za-z0-9' | fold -w 20 | head -1
}

database() {
    bin/arachni_web_task db:version >/dev/null 2>&1

    if [ $? -ne 0 ];
    then
        echo "Setting up database..."
        bin/arachni_web_task db:setup
    fi
}

setpass() {
    echo "Setting up a new password..."
    pass=$(genpass)
    bin/arachni_web_change_password "admin@admin.admin" "$pass"
    echo "Your new credentials are as follows..."
    echo
    echo "Username: admin@admin.admin"
    echo "Password: $pass"
    echo
}

startup() {
    echo
    echo "Booting web server...."
    echo
    bin/arachni_web --host 0.0.0.0
}

database
picture
logo
setpass
startup
