(mk-tower
 'p_eastpass "Eastpass"
 (list
      ".. .. {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
      ".. .. {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
      ".. .. .. {{ {{ {{ {{ xx ,, xx {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
      ".. .. .. {{ {{ {{ {{ w+ ,, w+ .. {{ {{ {{ ^^ ^^ ^^ ^^ ^^ "
      ".. .. .. .. .. .. .. xx ,, xx .. .. .. {{ ^^ ^^ ^^ ^^ ^^ "
      ".. .. .. .. .. xx xx xx ,, xx xx xx .. {{ {{ ^^ ^^ ^^ ^^ "
      ".. .. .. .. .. w+ ,, ,, ,, ,, ,, w+ .. .. {{ {{ ^^ ^^ ^^ "
      ".. .. .. .. .. x! ,, ,, ,, ,, ,, x! .. .. .. {{ {{ ^^ ^^ "
      ".. .. .. .. .. w+ ,, ,, ,, ,, ,, w+ .. .. .. .. {{ {{ ^^ "
      ".. .. .. .. .. ,, ,, ,, ,, ,, ,, ,, .. .. .. .. .. {{ ^^ "
      ".. .. .. .. .. w+ ,, ,, ,, ,, ,, w+ .. .. .. .. {{ {{ ^^ "
      ".. .. .. .. .. x! ,, ,, ,, ,, ,, x! .. .. .. {{ {{ ^^ ^^ "
      ".. .. .. .. .. w+ ,, ,, ,, ,, ,, w+ .. .. .. {{ ^^ ^^ ^^ "
      ".. .. .. .. .. xx xx xx ,, xx xx xx .. .. {{ {{ ^^ ^^ ^^ "
      ".. .. .. .. .. .. .. xx ,, xx .. .. .. {{ {{ ^^ ^^ ^^ ^^ "
      ".. .. .. .. .. .. .. w+ ,, w+ .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ "
      ".. .. .. {{ {{ {{ {{ xx ,, xx {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ "
      ".. .. {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
      ".. .. {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
  )
 (put (mk-ladder-down 'p_westpass 4 14) 14 9)
 (put (mk-windowed-door) 11 9)
 (put (mk-windowed-door)  5 9)

 (put (guard-pt 'knight)  6 9)
 (put (guard-pt 'knight)  7 9)
 (put (guard-pt 'squire)  8 10)
 (put (guard-pt 'squire)  8  10)

 (put (spawn-pt 'bandit) 3 8)
 (put (spawn-pt 'bandit) 4 9)
 )
