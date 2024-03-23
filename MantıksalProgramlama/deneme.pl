:- dynamic(hesap/5). 

banka(1, 'Banka Adı').
banka(2, 'Başka Banka').

hesap(123, 1, 'TR123456789', 1, 5000).
hesap(456, 2, 'TR987654321', 2, 3000).

musteri(1, '12345678901', 'Ahmet', 'Yılmaz', erkek).
musteri(2, '98765432109', 'Ayşe', 'Demir', kadın).

eft(FromAccount, ToAccount, Amount) :-
    hesap(FromAccount, _, _, _, Balance1),
    hesap(ToAccount, _, _, _, Balance2),
    Balance3 is Balance1 - Amount,
    Balance4 is Balance2 + Amount,
    Balance3 >= 0,
    retract(hesap(FromAccount, Bank1, IBAN1, Customer1, Balance1)),
    asserta(hesap(FromAccount, Bank1, IBAN1, Customer1, Balance3)),
    retract(hesap(ToAccount, Bank2, IBAN2, Customer2, Balance2)),
    asserta(hesap(ToAccount, Bank2, IBAN2, Customer2, Balance4)),
    musteri(Customer1, _, FirstName1, LastName1, _),
    musteri(Customer2, _, FirstName2, LastName2, _),
    format("EFT from customer ~w ~w to ~w ~w\n~w ~w balance Before-After: ~w TL - ~w TL\n~w ~w balance Before-After: ~w TL - ~w TL\n", 
           [FirstName1, LastName1, FirstName2, LastName2, FirstName1, LastName1, Balance1, Balance3, FirstName2, LastName2, Balance2, Balance4]).

havale(FromAccount, ToAccount, Amount) :-
    hesap(FromAccount, _, _, _, Balance1),
    hesap(ToAccount, _, _, _, Balance2),
    Balance3 is Balance1 - Amount,
    Balance4 is Balance2 + Amount,
    Balance3 >= 0,
    retract(hesap(FromAccount, Bank1, IBAN1, Customer1, Balance1)),
    asserta(hesap(FromAccount, Bank1, IBAN1, Customer1, Balance3)),
    retract(hesap(ToAccount, Bank2, IBAN2, Customer2, Balance2)),
    asserta(hesap(ToAccount, Bank2, IBAN2, Customer2, Balance4)),
    musteri(Customer1, _, FirstName1, LastName1, _),
    musteri(Customer2, _, FirstName2, LastName2, _),
    format("Havale from customer ~w ~w to ~w ~w\n~w ~w balance Before-After: ~w TL - ~w TL\n~w ~w balance Before-After: ~w TL - ~w TL\n", 
           [FirstName1, LastName1, FirstName2, LastName2, FirstName1, LastName1, Balance1, Balance3, FirstName2, LastName2, Balance2, Balance4]).
