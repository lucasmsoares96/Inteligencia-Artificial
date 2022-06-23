% progenitor(pai,filho)
progenitor(joao,joaquim).
progenitor(joao,serafina).
progenitor(joana,joaquim).
progenitor(joana,serafina).
progenitor(serafina,maria).
progenitor(serafina,ana).
progenitor(joaquim,marcelino).
progenitor(marcelino,aristides).
progenitor(maria,aristides).

% sexo(pessoa,sexo)
sexo(serafina,feminino).
sexo(joana,feminino).
sexo(maria,feminino).
sexo(ana,feminino).
sexo(joao,masculino).
sexo(joaquim,masculino).
sexo(aristides,masculino).
sexo(marcelino,masculino).

%irmã(irma,irmao)
irma(X,Y) :- progenitor(Z,X),progenitor(Z,Y),sexo(X,feminino),(X \== Y).
irmao(X,Y) :- progenitor(Z,X),progenitor(Z,Y),sexo(X,masculino),(X \== Y).

%descendente(descendente,ascendente)
descendente(X,Y) :- progenitor(Y,X).
descendente(X,Y) :- progenitor(W,X),descendente(W,Y).

%pais(pai, filho)
mae(X,Y) :- progenitor(X,Y),sexo(X,feminino).
pai(X,Y) :- progenitor(X,Y),sexo(X,masculino).

%avo(avo,neto)
avo(X,Y) :- progenitor(X,W),progenitor(W,Y).

%tio(tio,sobrinho)
tio(X,Y) :- progenitor(W,Y),(irmao(X,W);irma(X,W)).

%primo(primo,primo)
primo(X,Y) :- tio(Z,X),progenitor(Z,Y).

% 1. O Joaquim é filho do José?
%       progenitor(jose,joaquim).
% 2. Quem são os filhos da Joana?
%       progenitor(joana,X).
% 3. Quem são os primos do Marcelino?
%       primo(marcelino,X).
% 4. Quantos sobrinhos/sobrinhas com um Tio existem?
%       findall(X,tio(_,X),Y), sort(Y,A),length(A,B).
% 5. Quem são os ascendentes do Aristides?
%       descendente(aristides,X).
% 6. A Maria tem irmãos? E irmãs?
%       irma(maria,_).
%       irmao(maria,_).
