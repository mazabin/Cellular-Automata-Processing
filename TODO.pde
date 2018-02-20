/**
1. Naiwny rozrost ziaren z sąsiedztwem:
  a. Von Neumanna        --jest
  b. Moore'a             --jest
  c. Hexagonal left
  d. Hexagonal right
  e. Hexagonal random
  f. Pentagonal random
  
2. Warunki brzegowe
  a. periodyczne - zawijanie    vn, moore
  b. nieperiodyczne - odbijające  vn, moore
  
3. Losowanie zarodków
  a. losowe
  b. równomierne - w każdym rzędzie i w każdej kolumnie tyle samo ??
  c. losowe z promieniem R - od losowego ziarna dodajemy jeszcze R w około
  d. przez kliknięcie
  
 
  Do istniejącego GUI dodać:
    Radiobutton group wyboru sąsiedztwa
    Przycisk czyszczący planszę
    Radiobutton group warunków brzegowych
    Radiobutton group losowania zarodków
    Możliwość ustawienia rozmiaru planszy
              Rozmiar planszy - minimum 100x100, maksimum 1600x1200;        -- zmiana rozmiaru okna nie działa
              Rozmiar komórki wybiera użytkownik - miedzy 30 a 5;  5, 10, 15, 20, 25, 30 - 6 opcji    -- zmiana rozmiaru komórki trochę działa
              W zależności od rozmiaru komórki program proponuje rozmiar planszy (kwadrat) i ustawia skok co rozmiar komórki.     
  
  Zmiany w kodzie:
  Wyłaczyć do osobnych funkcji:
    Sprawdzanie sąsiedztw
    Sprawdzanie warunków brzegowych
    losowanie zarodków (b, c)
*/