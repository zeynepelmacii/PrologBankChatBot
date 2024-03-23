:- dynamic(hesap/5).

banka(101, 'Garanti').
banka(102, 'Akbank').

hesap(22, 102, 1, 123, 5000).
hesap(33, 102, 2, 456, 3000).

musteri(123, '41506400246', 'Zeynep', 'Elmacı', kadın).
musteri(456, '35176398725', 'Beyza', 'Erdoğan', kadın).

start :-
    write('  <<<<<<  PgBank’e Hoşgeldiniz  >>>>>>  \n'),
    write('Müşteri numaranızı giriniz: '),
    read(MusteriNo),
    write('Yapmak istediğiniz işlemi giriniz (EFT/Havale): '),
    read(Islem),
    write('Alıcının IBAN: '),
    read(Iban),
    write('Göndereceğiniz para(TL): '),
    read(Para),
    write('İşlemi onaylıyor musunuz? (Evet/Hayır): '),
    read(Onay),
    (Onay = 'Evet' ->
        (Islem = 'EFT' ->
            eft(MusteriNo, Iban, Para),
            write('İşlem başarıyla gerçekleştirildi.')
        ;
        Islem = 'Havale' ->
            havale(MusteriNo, Iban, Para),
            write('İşlem başarıyla gerçekleştirildi.')
        )
    ;
    Onay = 'Hayır' ->
        write('Güle güle.')
    ).


eft(MusteriNo, Iban, Para) :-
    hesap(_, _, Iban, aliciNo, Para2),
    hesap(_, _, _, MusteriNo, Para1),
    musteri(MusteriNo, _, fname1, lname1, _),
    musteri(aliciNo, _, fname2, lname2, _),
    Para3 is Para1 - Para,
    Para4 is Para2 + Para,
    retract(hesap(_, _, _, MusteriNo, Para1)),
    asserta(hesap(_, _, _, MusteriNo, Para3)),
    retract(hesap(_, _, Iban, aliciNo, Para2)),
    asserta(hesap(_, _, Iban, aliciNo, Para4)),
    write('\n-- EFT işlemi tamamlanmıştır --\n'),
    format('Gönderen: ~w,~w\n', [fname1, lname1]),
    format('Gönderenin işlem öncesi sonrası parası: ~w,~w\n', [Para1, Para3]),
    write('\n...'),
    format('Alıcı: ~w,~w\n', [fname2, lname2]),
    format('Alıcının işlem öncesi sonrası parası: ~w,~w\n', [Para2, Para4]).

havale(MusteriNo, Iban, Para) :-
    hesap(_, _, Iban, aliciNo, Para2),
    hesap(_, _, _, MusteriNo, Para1),
    musteri(MusteriNo, _, fname1, lname1, _),
    musteri(aliciNo, _, fname2, lname2, _),
    Para3 is Para1 - Para,
    Para4 is Para2 + Para,
    retract(hesap(_, _, _, MusteriNo, Para1)),
    asserta(hesap(_, _, _, MusteriNo, Para3)),
    retract(hesap(_, _, Iban, aliciNo, Para2)),
    asserta(hesap(_, _, Iban, aliciNo, Para4)),
    write('\n-- Havale işlemi tamamlanmıştır --\n'),
    format('Gönderen: ~w,~w\n', [fname1, lname1]),
    format('Gönderenin işlem öncesi sonrası parası: ~w,~w\n', [Para1, Para3]),
    write('\n...'),
    format('Alıcı: ~w,~w\n', [fname2, lname2]),
    format('Alıcının işlem öncesi sonrası parası: ~w,~w\n', [Para2, Para4]).
