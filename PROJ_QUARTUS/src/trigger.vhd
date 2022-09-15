library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity trigger is
    generic (
        C_ASYNC : boolean := FALSE
    );
    port (
        freq_vent_i : in std_logic;
        clk_i : in std_logic;
        bool_trigger_o : out std_logic
    );
end entity trigger;

architecture rtl of trigger is

    signal precedant, suivant : std_logic;
    
begin

    bascule_d_inst : entity work.bascule_d
    port map (
        pre_i => '0',
        clr_i => '0',
        clk_i => clk_i,
        d_i => freq_vent_i,
        q_o => bool_trigger_o,
        q_n_o => open
  );

  gen_sync : if C_ASYNC = FALSE generate
    precedant <= freq_vent_i;
  end generate gen_sync;

  gen_async : if C_ASYNC = TRUE generate
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            precedant <= freq_vent_i;
        end if;
    end process;
end generate gen_async;
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            suivant <= precedant;
        end if;
    end process;
    q_o <= '1' when suivant = '0' and precedant = '1' else '0';


end architecture;