# Plot CGI_GWLS and RCP_GWLS

ggplot(ven) +
  geom_point(aes(x = familyNumber, y=GWLS.DGV, colour ="CGI"), size=5) +
  geom_point(aes(x = familyNumber, y=RCP.DGV, colour = "RCP"), size=5) +
  scale_colour_manual("", 
                      breaks = c("CGI", "RCP"),
                      values = c("darkgreen", "red"))+
  xlab("Families")+
  ylab("Copy number variant segregation")+ 
  ggtitle("CNV segregation among epilepsy families for Complete Genomics Inc., data and reference coverage profile data")+
  theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20))+
  theme(axis.text.x = element_text(angle=45, hjust=1))


# Plot CGI and CGI_GWLS

ggplot(ven) +
  geom_point(aes(x = familyNumber, y=GWLS, colour ="CGI"), size=5) +
  geom_path(aes(x = familyNumber, y=GWLS,group = 1), lineend = "round", linejoin = "round",linemitre = 2, colour="darkgreen") +
  geom_point(aes(x = familyNumber, y=GWLS.DGV, colour = "CGI_Filtered"), size=5) +
  geom_path(aes(x = familyNumber, y=GWLS.DGV,group = 1), lineend = "round", linejoin = "round",linemitre = 2, colour="red") +
  scale_colour_manual("", 
                      breaks = c("CGI", "CGI_Filtered"),
                      values = c("darkgreen", "red"))+
  xlab("Families")+
  ylab("Copy number variant segregation")+ 
  ggtitle("Copy number variant segregation among epilepsy families for Complete Genomics Inc., data")+
  theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20))+
  theme(axis.text.x = element_text(angle=45, hjust=1))

# Plot RCP and RCP_GWLS

ggplot(ven) +
  geom_point(aes(x = familyNumber, y=RCP, colour ="RCP"), size=5) +
  geom_path(aes(x = familyNumber, y=RCP,group = 1), lineend = "round", linejoin = "round",linemitre = 2, colour="darkgreen") +
  geom_point(aes(x = familyNumber, y=RCP.DGV, colour = "RCP_Filtered"), size=5) +
  geom_path(aes(x = familyNumber, y=RCP.DGV,group = 1), lineend = "round", linejoin = "round",linemitre = 2, colour="red") +
  scale_colour_manual("", 
                      breaks = c("RCP", "RCP_Filtered"),
                      values = c("darkgreen", "red"))+
  xlab("Families")+
  ylab("Copy number variant segregation")+ 
  ggtitle("Copy number variant segregation among epilepsy families for reference coverage profile data")+
  theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20))+
  theme(axis.text.x = element_text(angle=45, hjust=1))