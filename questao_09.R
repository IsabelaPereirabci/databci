# Importa funções para banco de dados dentro do R
library(dplyr)

# Criando tabela auxiliar
auxiliar<-left_join(xml, Item, by=c("accesskey"="accesskey")) %>% 
select(dest_id, emit_id, QCom)

# Criando tabela test
test<-auxiliar %>% group_by(emit_id, dest_id) %>% 
mutate(soma=sum(QCom))

# Trazendo apenas a soma
test<-auxiliar %>% group_by(emit_id, dest_id) %>% 
mutate(soma=sum(QCom)) %>% 
distinct(emit_id, dest_id,.keep_all = TRUE)

# Removendo a coluna QCom, pois não é necessária
test<-auxiliar %>% group_by(emit_id, dest_id) %>% 
mutate(soma=sum(QCom)) %>% 
distinct(emit_id, dest_id,.keep_all = TRUE) %>% 
select(!QCom)

# Criando a tabela final, para exibição do resultado final da questão 09
# Trazendo apenas os 5 maiores resultados
final<-test %>% 
group_by(dest_id) %>%
arrange(desc(soma)) %>%
mutate(Rank=row_number()) %>% 
filter(Rank<=5)

# Removendo a coluna soma, pois não é mais necessária
# Além de ondernar(arrange) por dest_id
final<-test %>% 
group_by(dest_id) %>%
arrange(desc(soma)) %>%
mutate(Rank=row_number()) %>% 
filter(Rank<=5) %>% 
select(!soma) %>% 
arrange(dest_id)

# Renomeando as colunas para o que é pedido na questão 09
final<-test %>% 
group_by(dest_id) %>%
arrange(desc(soma)) %>%
mutate(Rank=row_number()) %>% 
filter(Rank<=5) %>% 
select(!soma) %>% 
arrange(dest_id) %>% 
rename(ID_destinatario=dest_id, ID_emissor=emit_id)



