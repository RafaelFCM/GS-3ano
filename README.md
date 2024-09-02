# Challenge Eurofarma 
### Equipe: PharmaConnect

<br/>

## Descrição

Desfio proprosto pela Eurofarma, solicitaram o desenvolvimento de um app/site/tecnologia para gerenciamento de treinamentos/cursos dos funcionários e desenvolvimento de um novo onboarding. Nós decidimos fazer um app, em Flutter.

<br/>
<br/>

## Apresentação

Você pode visualizar a apresentação do sprint 2 [aqui](https://www.canva.com/design/DAGCIdV_15Y/zjNBBTyH3omer3Kw5G6RIA/edit?utm_content=DAGCIdV_15Y&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

<br/>

Você pode visualizar a apresentação do sprint 3 [aqui](https://www.canva.com/design/DAGPR-LkevE/_KWiyFRO-YJMqJATMzaA4w/edit?utm_content=DAGPR-LkevE&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

<br/>
<br/>

## Ponto importantes

Quando é feito o git clone ou baixado o zip aqui do github para sua máquina, é necessário se atentar para possíveis erros que surgiram no vs code, para saber o que está dando errado você precisa dar um run no projeto e esperar as indicações do debug console.
Os erros mais comuns:

- Sua versão do flutter/sdk pode estar desatualizada, sendo assim, necessário dar um flutter upgrade no terminal. Ou dar um flutter -version e baseado na sua versão da máquina alterar a versão do projeto entrando no arquivo pubspec.yaml e alterando essa parte do código: <br/>
![image](https://github.com/user-attachments/assets/fe54698c-1dbe-4056-8522-05fbf9235f3e)

<br/>

- Sua versão do java jdk pode não ser o mesmo do projeto (17), podendo ser verificado no terminal com java --version, sendo assim, você vai no arquivo gradle.properties e comenta a parte do código que fala sobre o jdk, assim ele usa o jdk da sua máquina automaticamente. Siga esse passo a passo: <br/>
![image](https://github.com/user-attachments/assets/b7b75496-9e1b-4016-ad4d-beb87fe31645)

<br/>

- Problema no Daemon do Gradle, seguir passo a passo: vai no terminal do vs code, usa o comando cd andoird (para entrar na pasta android do projeto), depois o comando ./gradlew --stop, depois o flutter run.

<br/>

- Lembrando que toda vez que faz alguma alteração no código/configurações é necessário salvar o projeto e dar um flutter pub get no terminal do vs code.

<br/>

No trecho abaixo no começo do main.dart nós temos a chamada do banco de dados (db_service.dart), precisa deixar comentado para não reiniciar o banco para o padrão (infos mockadas) <br/>
![image](https://github.com/user-attachments/assets/294c76da-8a4f-4210-8348-23741361a987)

<br/>

Infos mockadas importantes no banco de dados (db_service.dart):
Logins para entrar no app, o login do suporte é o único impossivel de apagar na area de gerenciamento de usuários  <br/>
![image](https://github.com/user-attachments/assets/b3295b8b-0c18-473a-8ec1-bcab1c956d0d)

<br/>
<br/>

## Modelo de banco de dados:
![image](https://github.com/user-attachments/assets/e3e33ad9-0613-4e35-936d-695a8a87d942)

<br/>
<br/>

## Vídeo do projeto:

Você pode ver ele rodando [aqui](https://www.youtube.com/watch?v=vFxUZiXrKGw)
