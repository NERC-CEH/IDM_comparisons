##plots

sim_res <- read.csv("sim_results_collated_500.csv")

env_res <- read.csv("env_results_collated_500.csv")

#remove extreme MAE values
sim_res <- sim_res[sim_res$MAE < 7.5,]

library(ggplot2)

##bias cov present, MAE

sub1 <- sim_res[sim_res$Model %in% c("structured", "unstructuredcov", "jointcov", "covariatebias", "correlationbias_str") & sim_res$Scenario != "Large",]

p1 <- ggplot(sub1, aes(y = MAE, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "MAE \n", tag = "(a)") +
  scale_x_discrete(labels=c("correlationbias_str" = "Correlation", "covariatebias" = "Informed prior","jointcov" = "Joint likelihood", "structured" = "PA only", "unstructuredcov" = "PO only"))+
  theme_classic()+
  ylim(0,6)+
  theme(legend.position = "none") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank(),
        plot.tag = element_text(size = 10))


##bias cov absent, MAE

sub2 <- sim_res[sim_res$Model %in% c("structured", "unstructured", "joint", "covariate", "correlation_str")& sim_res$Scenario != "Large",]

p2 <- ggplot(sub2, aes(y = MAE, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "MAE\n", tag = "(b)") +
  scale_x_discrete(labels=c("correlation_str" = "Correlation", "covariate" = "Informed prior","joint" = "Joint likelihood", "structured" = "PA only", "unstructuredcov" = "PO only"))+
  ylim(0,6)+
  theme_classic()+ 
  theme(legend.position = "top") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank(),
        plot.tag = element_text(size = 10))

##bias cov present, corr

p3 <- ggplot(sub1, aes(y = correlation, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Correlation", tag = "(c)") +
  scale_x_discrete(labels=c("correlationbias_str" = "Correlation", "covariatebias" = "Informed prior","jointcov" = "Joint likelihood", "structured" = "PA only", "unstructuredcov" = "PO only"))+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank(),
        plot.tag = element_text(size = 10))


##bias cov absent, corr

p4 <- ggplot(sub2, aes(y = correlation, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Correlation", tag = "(d)") +
  scale_x_discrete(labels=c("correlation_str" = "Correlation", "covariate" = "Informed prior","joint" = "Joint likelihood", "structured" = "PA only", "unstructuredcov" = "PO only"))+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank(),
        plot.tag = element_text(size = 10))
  
##bias cov present, env

sub1e <- env_res[env_res$model %in% c("structured", "unstructuredbias", "jointbias", "covariatebias", "correlationbias") & env_res$Scenario != "Large",]

p5 <- ggplot(sub1e, aes(y = mean, x = model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Coefficient estimate\n", x = "Model", tag = "(e)") +
  scale_x_discrete(labels=c("correlationbias" = "Correlation", "covariatebias" = "Informed prior","jointbias" = "Joint likelihood", "structured" = "PA only", "unstructuredbias" = "PO only"))+
  ylim(-6,9)+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 1, hjust = 1),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        plot.tag = element_text(size = 10))+
  geom_hline(yintercept = 1.2,  col = "black", size = 0.7)

##bias cov absent, env

sub2e <- env_res[env_res$model %in% c("structured", "unstructured", "joint", "covariate", "correlation")& env_res$Scenario != "Large",]

p6 <- ggplot(sub2e, aes(y = mean, x = model), group = Scenario)  +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Coefficient estimate\n", x = "Model" , tag = "(f)") +
  scale_x_discrete(labels=c("correlation" = "Correlation", "covariate" = "Informed prior","joint" = "Joint likelihood", "structured" = "PA only", "unstructured" = "PO only"))+
  ylim(-6,9)+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 1, hjust = 1),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        plot.tag = element_text(size = 10))+
  geom_hline(yintercept = 1.2, col = "black", size = 0.7)
#, lty = "41"
get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}


leg <- get_legend(p2)

p2 <- p2 + theme(legend.position = "none")

library("gridExtra")
#p5 <- grid.arrange(p1,p2,p3,p4, ncol = 2, nrow = 2)
p7 <- grid.arrange(p1, p2, p3, p4, p5, p6, leg, ncol=2, nrow = 4, 
             layout_matrix = rbind(c(1,2),c(3,4), c(5,6), c(7,7)),
             widths = c(2.7, 2.7), heights = c(2, 2, 3.3, 0.2))

ggsave("Figure 2 v5.png", p7, device = "png", width = 15, height = 18.5, units = "cm")




## large scenario

sub1l <- sim_res[sim_res$Model %in% c("structured", "unstructuredcov", "jointcov", "covariatebias", "correlationbias_str") & sim_res$Scenario %in% c("Large","Default"),]

p1l <- ggplot(sub1l, aes(y = MAE, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "MAE \n", tag = "(a)") +
  scale_x_discrete(labels=c("correlationbias_str" = "Correlation", "covariatebias" = "Informed prior","jointcov" = "Joint likelihood", "structured" = "Structured only", "unstructuredcov" = "Unstructured only"))+
  ylim(0,6) +
  theme_classic()+
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank())

p3l <- ggplot(sub1l, aes(y = correlation, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Correlation", tag = "(b)") +
  scale_x_discrete(labels=c("correlationbias_str" = "Correlation", "covariatebias" = "Informed prior","jointcov" = "Joint likelihood", "structured" = "Structured only", "unstructuredcov" = "Unstructured only"))+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank())

sub1el <- env_res[env_res$model %in% c("structured", "unstructuredbias", "jointbias", "covariatebias", "correlationbias") & env_res$Scenario %in% c("Large", "Default"),]

p5l <- ggplot(sub1el, aes(y = mean, x = model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Coefficient estimate\n", x = "Model", tag = "(c)") +
  scale_x_discrete(labels=c("correlationbias" = "Correlation", "covariatebias" = "Informed prior","jointbias" = "Joint likelihood", "structured" = "PA only", "unstructuredbias" = "PO only"))+
  ylim(-6,9)+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 1, hjust = 1),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        plot.tag = element_text(size = 10))+
  geom_hline(yintercept = 1.2, linetype = "dashed")

get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}


legl <- get_legend(p1l)

p1l <- p1l + theme(legend.position = "none")

library("gridExtra")
#p5 <- grid.arrange(p1,p2,p3,p4, ncol = 2, nrow = 2)
p4l <- grid.arrange(p1l, p3l, p5l, legl, ncol=1, nrow = 4, 
                   layout_matrix = rbind(c(1),c(2), c(3), c(4)),
                   widths = c(2.7), heights = c(2, 2, 3.3, 0.2))

ggsave("Large scenario v3.png", p4l, device = "png", width = 15, height = 18.5, units = "cm")




sub2l <- sim_res[sim_res$Model %in% c("structured", "unstructured", "joint", "covariate", "correlation_str") & sim_res$Scenario %in% c("Large","Default"),]

p1l <- ggplot(sub2l, aes(y = MAE, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "MAE \n", tag = "(a)") +
  scale_x_discrete(labels=c("correlation_str" = "Correlation", "covariate" = "Informed prior","joint" = "Joint likelihood", "structured" = "Structured only", "unstructured" = "Unstructured only"))+
  ylim(0,6) +
  theme_classic()+
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank())

p3l <- ggplot(sub2l, aes(y = correlation, x = Model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Correlation", tag = "(b)") +
  scale_x_discrete(labels=c("correlation_str" = "Correlation", "covariate" = "Informed prior","joint" = "Joint likelihood", "structured" = "Structured only", "unstructured" = "Unstructured only"))+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank())

sub2el <- env_res[env_res$model %in% c("structured", "unstructured", "joint", "covariate", "correlation") & env_res$Scenario %in% c("Large", "Default"),]

p5l <- ggplot(sub2el, aes(y = mean, x = model), group = Scenario) +
  geom_boxplot(aes(fill = Scenario), outlier.shape = NA) +
  #facet_wrap(. ~ section, scales = "free") +
  labs(fill = "Scenario", y = "Coefficient estimate\n", x = "Model", tag = "(c)") +
  scale_x_discrete(labels=c("correlation" = "Correlation", "covariate" = "Informed prior","joint" = "Joint likelihood", "structured" = "PA only", "unstructured" = "PO only"))+
  ylim(-6,9)+
  theme_classic()+
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 1, hjust = 1),
        axis.text.y = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 10),
        plot.tag = element_text(size = 10))+
  geom_hline(yintercept = 1.2, linetype = "dashed")

get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}


legl <- get_legend(p1l)

p1l <- p1l + theme(legend.position = "none")

library("gridExtra")
#p5 <- grid.arrange(p1,p2,p3,p4, ncol = 2, nrow = 2)
p4l <- grid.arrange(p1l, p3l, p5l, legl, ncol=1, nrow = 4, 
                    layout_matrix = rbind(c(1),c(2), c(3), c(4)),
                    widths = c(2.7), heights = c(2, 2, 3.3, 0.2))

ggsave("Large scenario plot 2 v3.png", p4l, device = "png", width = 15, height = 18.5, units = "cm")

