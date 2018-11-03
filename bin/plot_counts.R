library(tidyverse)

args = commandArgs(trailingOnly = TRUE)

df = read_csv(args[1], col_names = c("file", "count"))

trim_file_names <- function(string){
  str2 = string %>%
    str_replace('data/', '') %>%
    str_replace('.tif', '')
  return(str2)
}

df = tibble(file = c('data/Dros_c2.tif', 'data/Dros_c1.tif'), count=c(42,32))

df = df %>%
  mutate(image = trim_file_names(file))

ggplot(df, aes(x=image, y=count)) +
  geom_bar(stat = 'identity', aes(fill=image)) +
  labs(title = 'Dros_c3 contains the most nuclei') +
  ylab('Nucleus counts') + 
  xlab(NULL) +
  theme_bw() +
  theme(legend.position = "none")

ggsave('plot.png', width = 4, height = 5)



