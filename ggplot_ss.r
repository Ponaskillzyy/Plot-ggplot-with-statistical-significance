#Dummy dataframe 
df <- data.frame(Baseline = runif(20, min = 0, max = 100), rela = runif(20, min = 35, max = 100), 
                 combo = runif(20, min = 15, max = 80),
                 nivo = runif(20, min = 0, max = 50))

#set themes_parameter
themes <- theme(axis.ticks.x = element_blank(), axis.text.x = element_blank(),
                panel.grid.major = element_blank(), panel.border = element_blank(),
                panel.grid.minor = element_blank(), 
                legend.text = element_text(face = "bold", size = 12),
                legend.title = element_text(face = "bold", size = 14),
                plot.title = element_text(face = "bold", size = 14),
                axis.title = element_text(face = "bold", size = 14),
                axis.text = element_text(face = "bold", size = 14),
                axis.line = element_line(colour = "black"))

#reshape data to fit plotting strategy
df <- reshape2::melt(df, value.name = "number_of_treg_cells", variable.name = "treatment")

#plot graph with statistical significance 
ggplot(df1, aes(x=treatment, y=number_of_treg_cells, fill = treatment)) + 
  geom_violin(trim = F) + geom_boxplot(width = 0.2) + theme_minimal() + 
  geom_pwc(aes(group = treatment), tip.length = 0,
           method = "wilcox_test", label = "p = {p.adj.format}{p.adj.signif}",
           p.adjust.method = "fdr", p.adjust.by = "group", hide.ns = T, label.size = 6, size = 1) + 
  ylab("% Tregs") + ggtitle("Percentage of Tregs Before and After Immunotherapy") + themes 

#save plot
ggsave("ggplot_ss.tiff", width = 20, height = 20, units = "cm")
