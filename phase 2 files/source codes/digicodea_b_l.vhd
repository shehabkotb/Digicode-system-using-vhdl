---------------structural output from loon-----------------------

LIBRARY sxlib_ModelSim;

entity digicodea_b_l is
   port (
      ck    : in      bit;
      vdd   : in      bit;
      vss   : in      bit;
      code  : in      bit_vector(3 downto 0);
      reset : in      bit;
      day   : in      bit;
      alarm : out     bit;
      door  : out     bit
 );
end digicodea_b_l;

architecture structural of digicodea_b_l is
Component oa22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x2
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component on12_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na4_x1
   port (
      i1  : in      bit;
      i0  : in      bit;
      i3  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nao22_x1
   port (
      i1  : in      bit;
      i0  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff1_x4
   port (
      ck  : in      bit;
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

signal digicode_cs     : bit_vector( 2 downto 0);
signal not_code        : bit_vector( 2 downto 1);
signal not_digicode_cs : bit_vector( 2 downto 0);
signal on12_x1_sig     : bit;
signal on12_x1_2_sig   : bit;
signal oa22_x2_sig     : bit;
signal o2_x2_sig       : bit;
signal not_reset       : bit;
signal not_aux3        : bit;
signal not_aux2        : bit;
signal not_aux1        : bit;
signal not_aux0        : bit;
signal no4_x1_sig      : bit;
signal no4_x1_2_sig    : bit;
signal no3_x1_sig      : bit;
signal no2_x1_sig      : bit;
signal no2_x1_2_sig    : bit;
signal nao22_x1_sig    : bit;
signal na4_x1_sig      : bit;
signal na4_x1_3_sig    : bit;
signal na4_x1_2_sig    : bit;
signal na3_x1_sig      : bit;
signal na3_x1_3_sig    : bit;
signal na3_x1_2_sig    : bit;
signal na2_x1_sig      : bit;
signal na2_x1_4_sig    : bit;
signal na2_x1_3_sig    : bit;
signal na2_x1_2_sig    : bit;
signal inv_x2_sig      : bit;

begin

not_aux0_ins : o2_x2
   port map (
      i0  => digicode_cs(2),
      i1  => digicode_cs(0),
      q   => not_aux0,
      vdd => vdd,
      vss => vss
   );

not_aux2_ins : a2_x2
   port map (
      i0  => not_digicode_cs(1),
      i1  => not_digicode_cs(0),
      q   => not_aux2,
      vdd => vdd,
      vss => vss
   );

not_aux1_ins : o2_x2
   port map (
      i0  => code(3),
      i1  => not_code(2),
      q   => not_aux1,
      vdd => vdd,
      vss => vss
   );

not_aux3_ins : o2_x2
   port map (
      i0  => code(0),
      i1  => not_code(1),
      q   => not_aux3,
      vdd => vdd,
      vss => vss
   );

not_digicode_cs_1_ins : inv_x2
   port map (
      i   => digicode_cs(1),
      nq  => not_digicode_cs(1),
      vdd => vdd,
      vss => vss
   );

not_digicode_cs_2_ins : inv_x2
   port map (
      i   => digicode_cs(2),
      nq  => not_digicode_cs(2),
      vdd => vdd,
      vss => vss
   );

not_digicode_cs_0_ins : inv_x2
   port map (
      i   => digicode_cs(0),
      nq  => not_digicode_cs(0),
      vdd => vdd,
      vss => vss
   );

not_code_2_ins : inv_x2
   port map (
      i   => code(2),
      nq  => not_code(2),
      vdd => vdd,
      vss => vss
   );

not_code_1_ins : inv_x2
   port map (
      i   => code(1),
      nq  => not_code(1),
      vdd => vdd,
      vss => vss
   );

not_reset_ins : inv_x2
   port map (
      i   => reset,
      nq  => not_reset,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => code(3),
      i1  => not_code(2),
      i2  => digicode_cs(0),
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i0  => code(2),
      i1  => not_aux3,
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_ins : no2_x1
   port map (
      i0  => o2_x2_sig,
      i1  => not_digicode_cs(1),
      nq  => no2_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_2_ins : na2_x1
   port map (
      i0  => code(3),
      i1  => not_digicode_cs(2),
      nq  => na2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => na2_x1_2_sig,
      i1  => no2_x1_sig,
      i2  => oa22_x2_sig,
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => not_reset,
      i1  => na3_x1_sig,
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

digicode_cs_0_ins : sff1_x4
   port map (
      ck  => ck,
      i   => na2_x1_sig,
      q   => digicode_cs(0),
      vdd => vdd,
      vss => vss
   );

no4_x1_ins : no4_x1
   port map (
      i0  => code(0),
      i1  => code(2),
      i2  => code(1),
      i3  => code(3),
      nq  => no4_x1_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_ins : na4_x1
   port map (
      i0  => not_digicode_cs(1),
      i1  => no4_x1_sig,
      i2  => digicode_cs(0),
      i3  => not_digicode_cs(2),
      nq  => na4_x1_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_2_ins : no2_x1
   port map (
      i0  => not_aux3,
      i1  => not_aux1,
      nq  => no2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_3_ins : na3_x1
   port map (
      i0  => digicode_cs(2),
      i1  => no2_x1_2_sig,
      i2  => digicode_cs(0),
      nq  => na3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_2_ins : na3_x1
   port map (
      i0  => not_reset,
      i1  => na3_x1_3_sig,
      i2  => na4_x1_sig,
      nq  => na3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

digicode_cs_1_ins : sff1_x4
   port map (
      ck  => ck,
      i   => na3_x1_2_sig,
      q   => digicode_cs(1),
      vdd => vdd,
      vss => vss
   );

na2_x1_3_ins : na2_x1
   port map (
      i0  => code(2),
      i1  => not_digicode_cs(2),
      nq  => na2_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_4_ins : na2_x1
   port map (
      i0  => not_aux1,
      i1  => not_digicode_cs(1),
      nq  => na2_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_2_ins : no4_x1
   port map (
      i0  => reset,
      i1  => not_code(1),
      i2  => code(0),
      i3  => code(3),
      nq  => no4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_2_ins : na4_x1
   port map (
      i0  => digicode_cs(0),
      i1  => no4_x1_2_sig,
      i2  => na2_x1_4_sig,
      i3  => na2_x1_3_sig,
      nq  => na4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_ins : inv_x2
   port map (
      i   => code(0),
      nq  => inv_x2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => code(1),
      i1  => inv_x2_sig,
      i2  => reset,
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_ins : on12_x1
   port map (
      i0  => not_aux0,
      i1  => code(3),
      q   => on12_x1_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_2_ins : on12_x1
   port map (
      i0  => code(3),
      i1  => day,
      q   => on12_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_3_ins : na4_x1
   port map (
      i1  => on12_x1_2_sig,
      i0  => code(2),
      i3  => on12_x1_sig,
      i2  => no3_x1_sig,
      nq  => na4_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_ins : nao22_x1
   port map (
      i1  => na4_x1_3_sig,
      i0  => not_aux2,
      i2  => na4_x1_2_sig,
      nq  => nao22_x1_sig,
      vdd => vdd,
      vss => vss
   );

digicode_cs_2_ins : sff1_x4
   port map (
      ck  => ck,
      i   => nao22_x1_sig,
      q   => digicode_cs(2),
      vdd => vdd,
      vss => vss
   );

door_ins : a2_x2
   port map (
      i0  => not_aux2,
      i1  => digicode_cs(2),
      q   => door,
      vdd => vdd,
      vss => vss
   );

alarm_ins : no2_x1
   port map (
      i0  => not_aux0,
      i1  => digicode_cs(1),
      nq  => alarm,
      vdd => vdd,
      vss => vss
   );


end structural;
