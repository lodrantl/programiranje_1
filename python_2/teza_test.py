import unittest
from teza import *


class TestTeza(unittest.TestCase):
    def test_init(self):
        janez = Oseba('Janez')
        self.assertEqual(janez.ime, 'Janez')

    def test_dodaj(self):
        janez = Oseba('Janez')
        janez.dodaj_meritev(2, 55.2)
        janez.dodaj_meritev(5, 56.1)
        janez.dodaj_meritev(8, 55.8)
        janez.dodaj_meritev(11, 55.0)
        self.assertEqual(janez.meritve, [(2, 55.2), (5, 56.1), (8, 55.8), (11, 55.0)])

    def test_preberi(self):
        janez = Oseba('Janez')
        janez.dodaj_meritev(2, 55.2)
        janez.dodaj_meritev(5, 56.1)
        janez.dodaj_meritev(8, 55.8)
        janez.dodaj_meritev(11, 55.0)
        osebe = preberi_podatke("text.txt")
        self.assertEqual(janez.meritve, osebe[0].meritve)
        self.assertEqual(janez.ime, osebe[0].ime)
        self.assertEqual(len(osebe), 3)

    def test_na_dan(self):
        janez = Oseba('Janez')
        janez.dodaj_meritev(2, 55.2)
        janez.dodaj_meritev(5, 56.1)
        janez.dodaj_meritev(8, 55.8)
        janez.dodaj_meritev(11, 55.0)

        self.assertEqual(janez.teza_na_dan(5),        56.1)
        self.assertEqual(janez.teza_na_dan(1),        55.2)
        self.assertEqual(janez.teza_na_dan(20),        55.0)
        self.assertEqual(janez.teza_na_dan(3),        55.5)


    def test_najtezji(self):
        self.assertEqual(najtezji_prostovoljec('text.txt', 10), "Miha")

if __name__ == '__main__':
    unittest.main()