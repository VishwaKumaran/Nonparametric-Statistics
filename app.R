#####################################
# TP : Statistique Non Paramétrique #
#####################################


library(shiny)

ui <- fluidPage(
    # Header
    tags$head(
        # Style -> type CSS
        tags$style(
            HTML("
                #sidebar {
                    position: fixed;
                }
            ")
        )
    ),
    fluidRow(
        column(
            3,
            navlistPanel(
                id = "sidebar",
                widths = c(12,12),
                "Paramètres",
                
                # Le nombre de réalisation
                tabPanel(
                    numericInput("n", "Nombre de Réalisations", 100, min = 10, max = 1000000)
                ),
                
                # Le coefficient k qui doit être supérieur à 1
                tabPanel(
                    numericInput('k', 'k', 5, min = 1, max = 100)
                )
            )
        ),
        column(
            9,
            
            # Barre de Navigation -> Container exercices
            navbarPage(
                title = "Statistique non Paramétrique",
                
                ######################################################
                ##################### Exercice 1 #####################
                ######################################################
                tabPanel(
                    "Fonction de répartition empirique",
                    fluidPage(
                        
                        ################ Question 1 ################
                        withMathJax(
                            paste0(
                                "
                                Soit \\(X\\), une variable aléatoire de densité 
                                $$f: \\rightarrow k (1-t)^{k-1} \\mathbb{1}_{t \\in [0,1]} \\quad , k \\in \\mathbb{N}^{*}$$
                                La fonction de répartition de \\(X\\) est donnée par
                                    $$
                                    F_X(t) =
                                      \\begin{cases}
                                        0 & \\text{si $t \\leq 0$} \\\\
                                        \\int_0^t f(x)dx & \\text{si $0 \\leq t \\leq 1$} \\\\
                                        1 & \\text{sinon}
                                       \\end{cases}
                                    $$
                                Avec \\(\\forall x \\in [0,t]\\),  \\(\\int_0^t f(x)dx\\) :
                                    $$
                                    \\begin{align}
                                      \\int_0^t f(x)dx &= \\int_0^t k(1-x)^{k-1}dx \\\\
                                                       &= k \\Bigg[ -\\frac{(1-x)^k}{k} \\Bigg]_0^t \\\\
                                                       &= k \\Bigg( -\\bigg(\\frac{1-t}{k}\\bigg)^k + \\frac{1}{k}\\Bigg) \\\\
                                                       &= 1 - (1-t)^k
                                    \\end{align}
                                    $$
                                "
                            )
                        ),
                        
                        ################ Question 2 ################
                        withMathJax(
                            paste0(
                                "
                                A présent, déterminons \\( F_X^{-1} \\) l'inverse de la fonction de répartition \\( F_X \\).
                                $$
                                F^{-1}_X = inf\\{ t \\in \\mathbb{R}, F(t) \\ge y  \\}
                                $$
                                D'où, \\( t \\in \\mathbb{R} \\),
                                $$
                                \\eqalign{
                                    1 - (1-t)^k	&= y                    \\cr
                                    (1-t)^k	    &= (1-y)                \\cr
                                    (1-t)	    &= (1-y)^{\\frac{1}{k}} \\cr    
                                    t           &= 1-(1-y)^{\\frac{1}{k}}
                                }
                                $$
                                "
                            )
                        ),
                        
                        ################ Question 3 ################
                        # On ajoute la phrase d'intro à la question qui contient des variables interactives
                        textOutput('Q3IntroSentence'),
                        
                        br(),
                        
                        # On ajoute le code afin correspondant au problème
                        uiOutput("Q3Code"),
                        
                        withMathJax(
                            paste0(
                                "
                                Ainsi, nous pouvons superposer l'histogramme de l'échantillon simulé ainsi que la densité \\( f \\).
                                "
                            )
                        ),
                        
                        ################ Question 4 ################
                        # Affichage du code R
                        uiOutput("Q4Code"),
                        
                        # Histogramme et la densité
                        plotOutput("Q4Hist"),
                        
                        ################ Question 5 ################
                        # Phrase d'intro
                        uiOutput("Q5Intro"),

                        withMathJax(
                            paste0(
                                "
                                Nous savons que l'on peut définir pour un \\( n \\)-échantillon iid de même loi que \\( X \\) la fonction de répartition empirique \\( F_n \\) définie par :
                                $$
                                \\forall x \\in \\mathbb{R}, \\quad F_n(x) = \\frac{1}{n} \\sum_{i=1}^n \\mathbb{1}_{ \\big\\{ X_i \\leq x \\big\\} }
                                $$
                                Ainsi, nous pouvons construire notre fonction de répartition empirique \\( F_n \\).
                                "
                            )
                        ),
                        
                        # Affichage du code R
                        uiOutput("Q5Code"),
                        
                        # Affichage de la fonction de répartition empirique
                        plotOutput("Q5Plot"),
                        
                        ################ Question 6 ################
                        # Phrase d'intro
                        uiOutput("Q6Intro"),
                        
                        # Définition du risque quadratique
                        paste0(
                            "
                            Soit \\( F \\) une fonction que l'on cherche à estimer, et \\( \\widehat{F} \\) un estimateur de \\( F \\).
                            Le risque quadratique ponctuel MSE au point x est donné par :

                            $$
                            \\mathcal{R}(\\widehat{F}(x), F(x)) = \\mathbb{E} \\big[ (\\widehat{F}(x) - F(x))^2 \\big]
                            $$
                            "
                        ),
                        
                        # Affichage du code
                        pre(
                            "# Risque quadratique",
                            "mean((fonEmpirique - F_x)^2)"
                        ),
                        
                        # Conclusion
                        uiOutput("Q6Conclusion"),
                        
                        ################ Question 7 ################
                        # Enoncé
                        paste0(
                            "
                            On a pour tout \\( x \\in \\mathbb{R,} \\)
                            $$
                            F_n(x) \\underset{n\\to+\\infty}{\\longrightarrow} F_X(x) \\qquad ps 
                            $$
                            
                            D'après le théorème de Glivenko-Cantelli, on a par l'application directe de la loi des grands nombres et du théorème du central limite
                            $$
                            \\sup_{x \\in \\mathbb{R}} \\lvert F_n(x) - F(x) \\rvert \\underset{n\\to+\\infty}{\\longrightarrow} 0
                            $$
                            "
                        ),
                        
                        # Code R
                        pre(
                            "max(abs(F_x - fonEmpirique))"
                        ),
                        
                        # Conclusion
                        uiOutput("Q7Conclusion")
                    )
                ),
                
                ######################################################
                ##################### Exercice 2 #####################
                ######################################################
                tabPanel(
                    "Estimateur histogramme",
                    
                ),
                
                ######################################################
                ##################### Exercice 3 #####################
                ######################################################
                tabPanel(
                    "Estimateurs par projection",
                    verbatimTextOutput("sd")
                )
            )
        )
    )
)

# On définit le serveur
server <- function(input, output, session) {
    
    #####################################
    ########      Exercice 1    #########
    #####################################
    
    ################ Question 3 ################
    
    #############    Algorithme    #############
    
    # Simulation de la méthode d'inversion
    
    t <- reactive({
        # On génére un échantillon qui suit une loi uniforme sur [0,1]
        runif(input$n, 0, 1)
    })
    
    Fmoins1 <- reactive({
        # L'inverse de la fonction de répartition
        1 - (1 - t())^(1/input$k)
    })
    
    # Construisons la densité
    # Les pas de x
    x <- seq(0, 1, 0.05)
    
    # Densité de f
    f <- reactive({
        input$k*(1-x)^(input$k-1)
    })
    
    #########        Render UI        ##########

    # Texte d'intro à la question 3
    output$Q3IntroSentence <- renderText({
        paste0(
            "Simulons par la méthode d'inversion ", input$n, " réalisations \\( i.i.d \\) de même loi que \\( X \\). Nous allons pour cela nous appuyer sur les résultats obtenus ci-dessus."
        )
    })
    
    # Code R
    output$Q3Code <- renderUI({
        pre(
            "# Paramètres",
            paste0("k = ", input$k),
            paste0("t = runif(", input$n, ", 0, 1)"),
            "",
            "# L'inverse de la fonction de répartition",
            "y = 1 - (1 - t)^(1/k)"
        )
    })
    
    ################ Question 4 ################
    
    #########        Render UI        ##########
    
    # Affichage de l'histogramme de l'échantillon simulé
    
    # Affichage du code R
    output$Q4Code <- renderUI({
        pre(
            "# Affichage de l'histogramme",
            "hist(y, prob=TRUE, breaks='Sturges')",
            "",
            "# Construction de la densité",
            "x = seq(0, 1, 0.05)",
            "f = k*(1-x)^(k-1)",
            "",
            "# Superposition de la densité sur l'histogramme",
            "lines(x, f, col=2)"
        )
    })
    
    # Affichage de l'histogramme et de la densité
    output$Q4Hist <- renderPlot({
        # On affiche l'histogramme de y
        hist(Fmoins1(), prob=TRUE, breaks="Sturges", main = "Histogramme de l'échantillon ainsi que sa densité")
        
        # Superposition de la densité sur l'histogramme
        lines(x, f(), col=2)
    })
    
    ################ Question 5 ################
    
    #############    Algorithme    #############
    
    # Construction de la fonction empirique
    buildFonEmpirique <- function(Fmoins1) {
        # Construction de notre fonction empirique (vecteur)
        funcEmpirique = rep(0, length(Fmoins1()))
        
        # On applique et calcule la fonction empirique à chaque temps
        for ( i in 1:length(Fmoins1)) { 
            funcEmpirique[i] = (1/length(Fmoins1)) * length(sort(Fmoins1)[1: i])
        }
        
        return(funcEmpirique)
    }
    
    # Fonction de répartition
    F_x <- reactive({
        1 - (1 - sort(Fmoins1()))^input$k 
    }) 
    
    # Fonction de répartition empirique
    fonEmpirique <- reactive({
        buildFonEmpirique(Fmoins1())
    })
    
    #########        Render UI        ##########
    
    # Affichage de la phrase d'intro
    output$Q5Intro <- renderUI({
        withMathJax(
            paste(
                "Cette fois-ci, nous allons nous intéresser à la fonction de répartition empirique \\( \\widehat{F}_{",
                input$n, "} \\)"
            )
        )
    })
    
    output$Q5Code <- renderUI({
        pre(
            "# Construction de la fonction de répartition empirique",
            "fonEmpirique = rep(0, length(y))",
            "",
            "for ( i in 1:length(y)) { ",
            "    fonEmpirique[i] = (1/length(y)) * length(sort(y)[1: i])",
            "}",
            "",
            "F_x = 1 - (1 - sort(y))^k"
        )
    })
    
    output$Q5Plot <- renderPlot({
        # Affichage de la fonction empirique
        plot(sort(Fmoins1()), fonEmpirique(), type= 's')
        
        # Superposer l'inverse de la fonction de répartition
        lines(sort(Fmoins1()), F_x(), type = 'l')
    })
    
    ################ Question 6 ################
    
    #######    Algorithme & Render UI   ########
    
    # Affichage du risque quadratique associé à la fonction de répartition empirique
    
    # Phrase d'introduction
    output$Q6Intro <- renderUI({
        withMathJax(
            paste(
                "Cherchons le risque quadratique associé à \\( \\widehat{F}_{", 
                input$n,
                "} \\)"
            )
        )
    })
    
    # Conclusion de la question
    output$Q6Conclusion <- renderUI({
        # Calcul du risque quadratique
        risk <- round(mean((fonEmpirique() - F_x())^2), 5)
        
        withMathJax(
            paste(
                "On obtient donc que le risque quadratique associé à \\( \\widehat{F}_{",
                input$n,
                "} \\) est de ", 
                risk,
                ". De plus, on sait que \\( \\forall x \\in \\mathbb{R}, \\mathcal{R}(\\widehat{F}(x), F_X(x)) \\leq \\frac{1}{4n} \\iff ", 
                risk," \\leq ", 1/(4*input$n), "\\)
                "
            )
        )
    })
    
    ################ Question 7 ################
    
    #######    Algorithme & Render UI   ########
    
    # Affichage de la convergence uniforme de l'estimateur de la fonction de répartition empirique
    output$Q7Conclusion <- renderUI({
        paste0(
            "On obtient par le théorème de Glivenko-Cantelli que 
            $$
            \\sup_{x \\in \\mathbb{R}} \\lvert F_{", input$n, "}(x) - F(x) \\rvert = ", round(max(abs(F_x() - fonEmpirique())), 6),
            "$$
            On a donc presque sûrement une convergence uniforme.
            "
        )
    })
    
    #####################################
    ########      Exercice 2    #########
    #####################################
    
    output$exo3 <- renderPrint({
        summary(cars)
    })
    
    #####################################
    ########      Exercice 3    #########
    #####################################
    
    
    
    # Question 1 : Creation de la fonction Trigo
    Trigo <- function(x,D) {
        # Creation d'un vecteur de taille D
        phi <- rep(1,D)
        
        # La première valeur est de 1
        phi[1] <- 1
        
        # Recuperation de la partie entière
        d <- (D%/%2)
        
        
        for (j in 1:d){
            # Cas pair
            phi[2*j] <- sqrt(2)*cos(2*pi*j*x)
            
            # Cas impair
            phi[2*j+1] <- sqrt(2)*sin(2*pi*j*x)
        }
        return(phi)
    }
    
    # Question 2 : Renvoie la décomposition de chaque élément de t dans la base trigonométrique.
    D <- 7
    xx <- seq(0,1,0.01)
    B <- matrix(0,length(xx),D)
    for (i in 1:length(xx)){
        B[i,] <- Trigo(xx[i],D)
    }
    
    # Question 4 : Les D estimateurs des coefficients du projeté orthogonal f_D de f sur S_D
    
    # Création d'une matrice qui renvoie la décomposition de tous les éléments de X dans la base trigonométrique
    C <- reactive({
        matrix(0,length(Fmoins1()),D)
    })

    reactive({
        for (i in 1:length(Fmoins1())){
            C[i,] <- Trigo(X[i],D)
        }
    })

    alpha <- rep(NA,D)

    reactive({
        for (j in 1:D){
            alpha[j] <- mean(C[,j])
        }
    })
    
    # Question 5 : En déduire l’estimateur fD du projeté orthogonal de f sur SD le sous-espace vectoriel de L2 ([0, 1]) engendré par la base trigonométrique pour l’échantillon simulé.
    Fd <- function(x, X, D){

        C <- matrix(0,length(X),D)
        for (i in 1:length(X)){
            C[i,] <- Trigo(X[i],D)
        }

        alpha <- rep(NA,D)
        for (j in 1:D){
            alpha[j] <- mean(C[,j])
        }

        B <- matrix(0,length(x),D)
        for (i in 1:length(x)){
            B[i,] <- Trigo(x[i],D)
        }

        value <- B%*%alpha
        return(value)
    }
    
    # Question 6 : Afficher sur le même graphique la densité f ainsi que l’estimateur fD pour plusieurs valeurs de D.
    f_density <- function(x_value){
        value <- 5*(1-x_value)^(5-1)
        return(value)
    }

    t_vec=seq(0,1,0.001)
    # plot(t_vec,Fd(t_vec,Fmoins1(),D=51),col=2,type="l")
    # lines(t_vec,f_density(t_vec),col=1,lw=2)
    # lines(t_vec,Fd(t_vec,Fmoins1(),7),col=4)
}

# Lancement de l'application
shinyApp(ui = ui, server = server)
