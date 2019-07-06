# OTRS

Imagem criada a partir da imagem do ubuntu com o propósito propósito de fornecer o ambiente para suportar as necessidades do sistema OTRS da versão 6.0.19.

Para utilizar basta executar o seguinte comando

```
docker -tid -p 8080:80 diegobulhoes/otrs
```

Para realizar a configuração básica.

```
http://ip_service:8080/otrs/installer.pl
```

Página principal do otrs

```
http://0.0.0.0:8080/otrs/index.pl
```

Durante o processo de configuração básica será necessário conectar o banco banco de dados, no caso do OTRS 6.0.19 é suportado o banco MySQL, PostgreSQL e Oracle SQL(Não configurado). Em relação ao banco MySQL será necessário configurar o plugin **caching_sha2_password**.


