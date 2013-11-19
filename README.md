sandbox
=======

Sandbox for bubo application

To make your app fully runnable, follow these steps:
* create sandbox project via composer: composer create-project project-bubo/sandbox your-app-name -s dev
* setup permissions: chmod 777 -R log/ temp/ www/media
* allow your host: modify project config file app/FrontModule/SandboxModule/config/project.neon

TODO add sql install file
