calc_indicador_8A <- function(df) {
  df_alvo <- df %>% select(Ano, UF, Capital, RM_RIDE, V1023, V2007, V2009, VD3002, V1028, Estrato, UPA) %>%
    filter(RM_RIDE == 26) %>%
    filter(V1023 == 1) %>%
    filter(V2009 >= 18 & V2009 <= 29) %>%
    filter(!is.na(VD3002)) %>%
    mutate(anos_estudo_ponderado = VD3002*as.numeric(V1028))

  total_anos_estudo_ponderado <- sum(df_alvo$anos_estudo_ponderado)
  total_anos_populacao_ponderado <- sum(as.numeric(df_alvo$V1028))
  indicador_8A <- total_anos_estudo_ponderado/total_anos_populacao_ponderado

  return(indicador_8A)
}

calc_indicador_8B <- function(df) {
  df_alvo <- df %>% select(Ano, UF, Capital, RM_RIDE, V1022, V2007, V2009, VD3002, V1028, Estrato, UPA) %>%
    filter(RM_RIDE == 26) %>%
    filter(V1022 == 2) %>%
    filter(V2009 >= 18 & V2009 <= 29) %>%
    filter(!is.na(VD3002)) %>%
    mutate(anos_estudo_ponderado = VD3002*as.numeric(V1028))

  total_anos_estudo_ponderado <- sum(df_alvo$anos_estudo_ponderado)
  total_anos_populacao_ponderado <- sum(as.numeric(df_alvo$V1028))
  indicador_8B <- total_anos_estudo_ponderado/total_anos_populacao_ponderado

  return(indicador_8B)
}

calc_indicador_8C <- function(df_anual) {
  df_anual_recife <- df_anual %>% select(Ano, UF, Capital, RM_RIDE, V1022, V1023, V2007, V2009, VD3002, V1032, VD5005, Estrato, UPA) %>%
    filter(RM_RIDE == 26) %>%
    filter(V1023 == 1) %>%
    filter(!is.na(VD5005))

  # calcula primeiro quartil
  quantile_vals <- quantile(df_anual_recife$VD5005)
  primeiro_quartil <- quantile_vals[['25%']]

  # seleciona os 25% mais pobres da população
  df_anual_recife_quartil <- df_anual_recife %>% filter(VD5005 <= primeiro_quartil)

  # filtra para população alvo...
  df_alvo <- df_anual_recife_quartil %>% filter(V2009 >= 18 & V2009 <= 29) %>%
    filter(!is.na(VD3002)) %>%
    mutate(anos_estudo_ponderado = VD3002*as.numeric(V1032))

  total_anos_estudo_ponderado <- sum(df_alvo$anos_estudo_ponderado)
  total_anos_populacao_ponderado <- sum(as.numeric(df_alvo$V1032))
  indicador_8C <- total_anos_estudo_ponderado/total_anos_populacao_ponderado

  return(indicador_8C)
}

calc_indicador_8D <- function(df) {
  ## pop. preta ##
  df_preta <- df %>% select(Ano, UF, Capital, RM_RIDE, V2010, V1023, V2007, V2009, VD3002, V1028, Estrato, UPA) %>%
    filter(RM_RIDE == 26) %>%
    filter(V1023 == 1) %>%
    filter(V2010 == 2 | V2010 == 4) %>% # preta ou parda
    filter(V2009 >= 18 & V2009 <= 29) %>%
    filter(!is.na(VD3002)) %>%
    mutate(anos_estudo_ponderado = VD3002*as.numeric(V1028))

  total_anos_estudo_ponderado_preta <- sum(df_preta$anos_estudo_ponderado)
  total_anos_populacao_ponderado_preta <- sum(as.numeric(df_preta$V1028))
  indicador_8D_preta <- total_anos_estudo_ponderado_preta/total_anos_populacao_ponderado_preta

  ## pop. branca ##
  df_branca <- df %>% select(Ano, UF, Capital, RM_RIDE, V2010, V1023, V2007, V2009, VD3002, V1028, Estrato, UPA) %>%
    filter(RM_RIDE == 26) %>%
    filter(V1023 == 1) %>%
    filter(V2010 == 1 | V2010 == 3) %>% # branca ou amarela
    filter(V2009 >= 18 & V2009 <= 29) %>%
    filter(!is.na(VD3002)) %>%
    mutate(anos_estudo_ponderado = VD3002*as.numeric(V1028))

  total_anos_estudo_ponderado_branca <- sum(df_branca$anos_estudo_ponderado)
  total_anos_populacao_ponderado_branca <- sum(as.numeric(df_branca$V1028))
  indicador_8D_branca <- total_anos_estudo_ponderado_branca/total_anos_populacao_ponderado_branca

  indicador_8D <- indicador_8D_preta/indicador_8D_branca

  return(indicador_8D)
}