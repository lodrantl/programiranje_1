class Oseba:
    def __init__(self, ime):
        self.ime = ime
        self.meritve = []
    def __repr__(self):
        return "{} {}".format(self.ime, self.meritve)
    def dodaj_meritev(self, dan, teza):
        self.meritve.append((dan, teza))
    def teza_na_dan(self, d):
        zm = None
        for dan, teza in self.meritve:
            if dan == d:
                return teza
            if dan < d:
                zm = (dan, teza)
            if dan > d:
                if zm == None:
                    return teza
                dan1, teza1 = zm
                k = (teza - teza1) / (dan - dan1)
                n = teza1 - k * dan1
                return k * d + n
        if zm == None:
            return None
        return self.meritve[-1][1]


def preberi_podatke(file):
    with open(file) as f:
        osebe = []
        for line in f:
            line = line.strip()
            if not line.startswith("*"):
                osebe.append(Oseba(line))
            else:
                z, d, t = line.split(" ")
                osebe[-1].dodaj_meritev(int(d), float(t))
        return osebe

def najtezji_prostovoljec(ime, dan):
    osebe = preberi_podatke(ime)
    max = (-1, "")
    for o in osebe:
        t = o.teza_na_dan(dan)
        if t != None and t > max[0]:
            max = (t, o.ime)
    return max[1]
