# Funcao que cria graficos do ggpairs que criei para utilizar em um 
# trabalho em 08/11/2018
# esta funcao sera modificada!

grafico_descritivo <- function(x, colNames = NULL, color = NULL,colors=NULL) {
  
  # Conferir se usuario altetrou a
  # ordem das colunas e linhas do do output:
  if (is.null(colNames)) {
    colNames <- colnames(x)
  }
  # Manipulacao inicial
  temp <-
    x %>%
    # se a variavel for de "0,1" transformar e fator
    mutate_if( ~ (length(table(.x))==2), as.factor) %>% 
    select(one_of(colNames))  # ordenando para aparecer no grafico
  
  # se o valor de cor nao estiver especificado
  if (is.null(color)) {
    g <-  # grafico de dispersao customizado
      ggpairs(temp, aes(alpha = 0.3),
              lower = list(combo = wrap(
                "facethist", bins = 30, position = "dodge")))
    # se o valor estiver especificado
  } else{
    g <- # grafico de dispersao customizado
      ggpairs(temp, aes(color = factor(!!as.name(color)), alpha = 0.3),  
              lower = list(combo = wrap(
                "facethist", bins = 30, position = "dodge")))
  }
  
  if(!is.null(colors)){ 
    p <- g + theme_bw()
    
    for(i in 1:p$nrow) {
      #https://stackoverflow.com/questions/34740210/how-to-change-the-color-palette-for-ggallyggpairs
      for(j in 1:p$ncol){
        p[i,j] <- p[i,j] + 
          scale_fill_manual(values=colors) +
          scale_color_manual(values=colors)  
      }
    }
    p
  }else{
    g + theme_bw()  # + tema de fundo branco
  }
  
}
