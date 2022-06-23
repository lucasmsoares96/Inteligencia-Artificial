% start() :- write("Digite o valor de X:"),
%             nl,read(X),
%             nl,write(X).

% tipos de recursos
tipo(sala).
tipo(laboratorio).
tipo(ginasio).
tipo(auditorio).
recurso(sala,301).
recurso(sala,302).
recurso(sala,303).
recurso(sala,304).
recurso(sala,305).
recurso(sala,306).
recurso(laboratorio,602).
recurso(laboratorio,604).
recurso(laboratorio,606).
recurso(laboratorio,608).
recurso(laboratorio,609).
recurso(laboratorio,610).
horarios("07:00").
horarios("08:00").
horarios("09:00").
horarios("10:00").
horarios("11:00").
horarios("12:00").
horarios("13:00").
horarios("14:00").
horarios("15:00").
horarios("16:00").
horarios("17:00").
horarios("18:00").
horarios("19:00").
horarios("20:00").
horarios("21:00").
horarios("22:00").
horarios("23:00").
dias("24/06").
dias("25/06").
dias("26/06").
dias("27/06").
dias("28/06").
dias("29/06").
dias("30/06").
dias("01/07").
dias("02/07").
dias("03/07").
dias("04/07").
dias("05/07").
dias("06/07").
dias("07/07").
dias("08/07").
dias("09/07").
dias("10/07").
dias("11/07").
dias("12/07").
dias("13/07").
dias("14/07").
dias("15/07").
dias("16/07").
dias("17/07").
dias("18/07").
dias("19/07").
dias("20/07").
dias("21/07").
dias("22/07").
dias("23/07").
dias("24/07").
dias("25/07").
dias("26/07").
dias("27/07").
dias("28/07").
dias("29/07").
dias("30/07").
dias("31/07").

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

operacao(Op) :- 
                (
                    ((Op =:= 2), listar());
                    ((Op =:= 1; Op=:=3),
                    write("Para qual dos seguintes tipos de recurso?\n"),
                    forall(tipo(X), format("~w \n", [X])),
                    nl,read(T),
                    (
                        tipo(T),recursos(Op,T);
                        write("O tipo que você escolheu não existe, tente outro!"),
                        operacao(Op)
                    ))
                ).

recursos(Op,T) :- 
            write("Para qual dos seguintes recursos?:\n"),
            forall(recurso(T,X),format("~w\n",[X])),
            nl,read(R),
            (
                recurso(T,R),dataEHora(Op,T,R);
                write("O recurso que você escolheu não existe, tente outro!"),
                recursos(Op,T)
            ).

dataEHora(Op,T,R) :- 
                write("Informe a data desejada \"dd/mm\"\n"),
                nl,read(D),
                (
                    (
                        dias(D),write("Informe a hora desejada \"hh:mm\"\n"),
                        nl,read(H),(horarios(H); writeln("Horario invalido, apenas de 7 as 23 e horas inteiras!"),dataEHora(Op,T,R)),
                        (
                            ((Op =:= 1), agendar(T,R,D,H));
                            ((Op =:= 3), cancelar(T,R,D,H))
                        )
                    );(write("Data ainda não cadastrada, apenas datas 1 mes após este!"),dataEHora(Op,T,R))
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
