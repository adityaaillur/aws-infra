    #!/bin/bash

    echo --start--
    echo "[Unit]
    Description=Webapp Service
    After=network.target

    [Service]
    Environment="DB_HOST=${element(split(":", db_host), 0)}"
    Environment="DB_USER=${db_username}"
    Environment="DB_PASSWORD=${db_password}"
    Environment="DB_DATABASE=${db_name}"
    Environment="AWS_BUCKET_NAME=${aws_s3_bucket}"
    Environment="AWS_REGION=${aws_region}"
    Type=simple
    User=ec2-user
    WorkingDirectory=/home/ec2-user/webapp
    ExecStart=/usr/bin/node /home/ec2-user/webapp/index.js
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/webapp.service
    sudo systemctl daemon-reload
    sudo systemctl start webapp.service
    sudo systemctl enable webapp.service
    echo --end--