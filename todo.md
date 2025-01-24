
# OBJETIVO = Você tem que sair de dentro do RU

    Onde que a gente vai começar
    Do lado do portão, mas o portão ta trancado.

# Como Alcançar

    Pegar os pedaços de chave para abrir o portão.

# Requisitos

## Modelos 3D

- [] Criar Objetos Interativos
    - [] Criar pedaços de Chave (4 Pedaços de Chave);
    - [] Criar Chave Inteira (Que só vai existir quando juntar as 4 Chaves);
    - [] Bolsa;
    - [] Cartão do RU (Para passar na catraca);
    - [] Dinheiro (Para abastecer o cartão);
    - [] Máquina de por crédito (Para abastecer o cartão);
    - [] Bandejão de Água para lavar talher;
    - [] Bandeja;
    - [] Porta Talher;
    - [] Prato Sujo;
    - [] Garfo e Faca Sujos;
    - [] Prato;
    - [] Garfo e Faca;
    - [] Pano;
    - [] Doces e Embalagem de Doces;
    - [] Lixeira;
    - [] Refeitório;
    - [] Catraca;

### Desejavéis


## Sistemas

### Visuais

- [] Criar um sistema de Interação com os objetos
    - [] Ao passar o mouse, o objeto deve iluminar (se for facil) e mostrar o nome (no caso de pegar) ou ação;
    - [] Ao clicar com o botão esquerdo eu vou executar a ação e vai informar o que eu posso fazer;
    - [] Ao clicar com o botão esquerdo eu vou obter o objeto ele vai pro menuzinho, ao obter, deve aparecer uma mensagem indicando que o objeto foi obtido
- [] Criar um menu para objetos (apenas visual);
- [] Criar um menu de início de jogo;

### Logicos

- [] Criar um sistema de liberar etapas de acordo com os itens
    - [] Passar o cartão na catraca (precisa do cartao e dinheiro)
    - [] Colocar comida (Precisa de prato limpo, garfo e faca)
    - [] Jogar talheres para lavar (Precisa de prato sujo, gargo e faca sujos)
    - [] Jogar Embalagem fora (Precisa da embalagem vazia)

- [] Criar um sistema de armazenamento dos objetos no menu;

- [] Criar um sistema de countdown que poderá modificar muitos aspectos do jogo (Tipo como se fosse um gameManager);
    - [] Ele vai ser capaz de aumentar ou diminuir a iluminação;
    - [] Ele vai ser capaz de aumentar ou diminuir a velocidade da lesma ou modificar o estado dela;
    - [] Ele vai ser capaz de terminar o jogo;

## Inimigo

 O inimigo é uma lesma que vai andar muito devagar, se ela encostar no player,
 ele morre e o jogo reinicia porém o jogo tem um countdown, a cada minuto
 passado a velocidade da lesma aumenta.

 O inimigo é o tempo, um countdown inicia com o jogo e se você não conseguir
 fugir, vc perde;


- [] Temos que usar IA nele;

## Como pegar as chaves

 1 - Encontrar o dinheiro, encontrar o cartão, ir na máquina de crédito pra por dinheiro, passar na catraca você pega um Prato, uma faca e um garfo, depois bota a comida no refeitório e pode por ela na mesa (assim você irá comê-la e se engasgara com um pedaço de chave)
 2 - Pegar um Prato, uma faca e um garfo sujos e jogar no Bandejão de Água, você conseguirá perceber um objeto la dentro (que é a chave);
 3 - Voltar no refeitório e pegar um bombom, depois que pegar, vc vai usá-lo (que é comê-lo). Ao comê-lo, vc ganhará um saco de bombomo vazio. Para conseguir a nova chave jogue o saco de bombom no lixo vermelho (Plástico)
 3.1 - Encontrar saco de bombom vazio e jogar no lixo vermelho (Plástico) -- Caso não consiga implementar


