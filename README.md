# Prediction of SOH & RUL of Lithium-Ion Batteries

![Curva SOH](/RUL.png)

Questo progetto affronta la **stima dello State of Health (SOH)** e della **Remaining Useful Life (RUL)** delle batterie agli ioni di litio, utilizzando il **NASA Battery Dataset** come base sperimentale.  
L’obiettivo è sviluppare un approccio di **manutenzione predittiva** che consenta di monitorare il degrado delle batterie e prevedere la loro vita utile residua, migliorando così affidabilità e gestione.

---

## Metodologia

Il lavoro si fonda su una pipeline completa, dalla preparazione dei dati alla costruzione e valutazione dei modelli predittivi:

1. **Data Processing**  
   Il dataset NASA è stato analizzato e ripulito, escludendo i cicli non significativi e mantenendo informazioni di tensione, corrente, temperatura e capacità. È stato costruito un dataset strutturato in MATLAB, includendo variabili come SOH, RUL e parametri temporali.

2. **Feature Extraction**  
   Sono stati definiti specifici indici di salute (HI1, HI2, HI3) basati su differenze di tensione, corrente e tempo, insieme a statistiche derivate (media, varianza, valori min/max di corrente e tensione).  

3. **Feature Correlation**  
   Le correlazioni (Pearson, Kendall, Spearman) hanno permesso di selezionare le variabili più rilevanti. Gli indici di salute si sono dimostrati fortemente correlati con il SOH, rendendoli centrali per la fase predittiva.

4. **Modelli Predittivi**  
   - **Gaussian Process Regression (GPR)** per la stima del SOH. Questa tecnica non parametrica permette di modellare relazioni non lineari, gestire dataset ridotti e restituire anche un livello di incertezza delle previsioni.  
   - **Regressione Lineare (fitlm)** per la stima della RUL, basata sui valori di SOH previsti. Nonostante la semplicità, si è dimostrata affidabile e meno costosa dal punto di vista computazionale.  
   - È stato testato anche un modello **LSTM**, ma con risultati meno soddisfacenti rispetto all’approccio GPR + regressione lineare, sia per accuratezza che per complessità.

5. **Validazione**  
   La validazione è stata condotta con tecnica *leave-one-out*, utilizzando ogni batteria a turno come set di test. Le performance sono state valutate tramite **MSE, RMSE e MAE**, mostrando una buona capacità di previsione soprattutto quando il training avviene su un numero elevato di cicli.

---

## Risultati e Conclusioni

- La **GPR** si è confermata uno strumento potente per la stima del SOH, capace di adattarsi a dati non lineari e fornire stime di confidenza.  
- La **regressione lineare** si è rivelata una scelta pragmatica per la predizione della RUL, garantendo un compromesso tra accuratezza e semplicità.  
- L’approccio combinato GPR + regressione lineare fornisce una base solida per applicazioni reali di prognostica sulle batterie, pur lasciando spazio a ottimizzazioni e a futuri miglioramenti (ad esempio reti neurali più leggere e architetture ibride).

---

## Repository e Codice

Il codice MATLAB sviluppato per il preprocessing, l’estrazione delle feature e la costruzione dei modelli è disponibile nel repository GitHub:  
👉 [PredictionSOH-RUL](https://github.com/sergytube/PredictionSOH-RUL)

---

## Come inserire immagini nel README

Per aggiungere immagini esplicative, puoi usare la sintassi Markdown:

```markdown
![Testo alternativo](path/to/image.png)
