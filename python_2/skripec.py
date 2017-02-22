import copy


class Skripec:
    def __init__(self, levo, desno):
        self.levo = levo
        self.desno = desno

    def __repr__(self):
        return "Skripec({}, {})".format(self.levo, self.desno)

    def miruje(self):
        return self.levo.teza() == self.desno.teza() and self.levo.miruje() and self.desno.miruje()

    def teza(self):
        return self.levo.teza() + self.desno.teza()

    def koliko_dodati(self):
        c = copy.deepcopy(self)
        c.uravnotezi()
        return c.teza() - self.teza()

    def uravnotezi(self):
        self.desno.uravnotezi()
        self.levo.uravnotezi()

        lt = self.levo.teza()
        dt = self.desno.teza()
        if lt > dt:
            self.desno.dodaj(lt - dt)
        elif lt < dt:
            self.levo.dodaj(dt - lt)

    def dodaj(self, kg):
        self.levo.dodaj(kg / 2)
        self.desno.dodaj(kg / 2)


class Utez:
    def __init__(self, teza):
        self.t = teza

    def __repr__(self):
        return "Utez({})".format(self.t)

    def miruje(self):
        return True

    def teza(self):
        return self.t

    def uravnotezi(self):
        return

    def dodaj(self, kg):
        self.t = self.t + kg


s = Skripec(
    Skripec(Utez(2), Utez(4)),
    Skripec(Utez(3), Skripec(Utez(2), Utez(1)))
)
t = Skripec(
    Skripec(Utez(4), Utez(4)),
    Skripec(Utez(4), Skripec(Utez(2), Utez(2)))
)

print(s.miruje())
print(t.miruje())

print(s.koliko_dodati())
print(t.koliko_dodati())

print(s)
d = copy.deepcopy(s)
d.uravnotezi()
print(s)
print(d)
