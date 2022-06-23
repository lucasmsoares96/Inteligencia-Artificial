% start() :- write("Digite o valor de X:"),
%             nl,read(X),
%             nl,write(X).

% tipos de recursos
tipo(sala).
tipo(laboratorio).

recurso(sala,301).
recurso(sala,302).
recurso(sala,303).
recurso(laboratorio,602).
recurso(laboratorio,604).
recurso(laboratorio,606).

status(aprovado).
status(pendente).


% base de conhecimento dinâmica
% agendamento(tipo,recuros,data,hora)
:- dynamic agendamento/5.
agendamento(sala,301,"25/06","10:00",aprovado).
agendamento(sala,302,"26/06","11:00",pendente).
agendamento(laboratorio,602,"27/06","12:00",pendente).
agendamento(laboratorio,604,"28/06","13:00",aprovado).

:-initialization(inicio()).

inicio() :- nl,
            write("Olá! Eu sou a sua assitente de agendamento. Como posso te ajudar?: \n"),
            write("1) Solicitar reserva\n"),
            write("2) Verificar status das solicitações\n"),
            write("3) Cancelar solicitação\b"),
            nl,read(Op),
            operacao(Op).

operacao(Op) :- tty_clear,
                (
                    ((Op =:= 2), listar());
                    ((Op =:= 1; Op=:=3),
                    write("Para qual dos seguintes tipos de recurso?\n"),
                    forall(tipo(X), format("~w \n", [X])),
                    nl,read(T),
                    (
                        tipo(T),recursos(Op,T);
                        operacao(Op)
                    ))
                ).

recursos(Op,T) :- tty_clear,
            write("Para qual dos seguintes recursos?:\n"),
            forall(recurso(T,X),format("~w\n",[X])),
            nl,read(R),
            (
                recurso(T,R),dataEHora(Op,T,R);
                recursos(Op,T)
            ).

dataEHora(Op,T,R) :- tty_clear,
                write("Informe a data desejada \"dd/mm\"\n"),
                nl,read(D),
                tty_clear,
                write("Informe a hora desejada \"hh:mm\"\n"),
                nl,read(H),
                tty_clear,
                (
                    ((Op =:= 1), agendar(T,R,D,H));
                    ((Op =:= 3), cancelar(T,R,D,H))
                ).

    
listar() :- forall(agendamento(T,R,D,H,S), (format("~w   ~w   ~w   ~w   ~w\n",[T,R,D,H,S]))),
                inicio().

cancelar(T,R,D,H) :- (agendamento(T,R,D,H,_)-> 
                        nl,write("Pedido cancelado com sucesso\n"),
                        retract(agendamento(T,R,D,H,_)),
                        inicio();
                        nl,write("Esse recurso não está ocupado\n"),
                        inicio()
                    ).

agendar(T,R,D,H) :- (agendamento(T,R,D,H,_)-> 
                        nl,write("Esse recurso já está ocupado\n"),
                        inicio();
                        assertz(agendamento(T,R,D,H,pendente)),
                        nl,write("Seu pedido foi realizado com sucesso!\n"),
                        forall(agendamento(T,R,D,H,S), (format("~w   ~w   ~w   ~w   ~w\n",[T,R,D,H,S]))),
                        inicio()
                    ).
