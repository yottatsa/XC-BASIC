proc reset_game
  \framecount! = 0
  \framecount_shooting! = 0
  \event! = 0
  
  \enemy_bullet_on![0] = 0
  \enemy_bullet_on![1] = 0
  \enemy_bullet_on![2] = 0
  \sound_phase! = 3

  rem -- clear sprite detection register
  rem -- by reading the value

  drop_this! = peek!(\SPR_SPR_COLL)

  \ship_pos = 176
  poke \SPRITE1_X, \ship_pos
  poke $d010, peek!($d010) & %11111110
  poke \SPRITE0_SHAPE, 255

  poke \SPRITE6_X, \ufo_pos
  if \ufo_pos > 255 then
    poke $d010, peek!($d010) | %01000000
  else
    poke $d010, peek!($d010) & %10111111
  endif

  call update_backup_ships

  for i! = 0 to 15
    poke \SPR_CNTRL, i! & %00000001
    for j! = 0 to 25
      watch \RASTER_POS, 0
    next j!
  next i!

   poke \SPR_CNTRL, %01000001
endproc
