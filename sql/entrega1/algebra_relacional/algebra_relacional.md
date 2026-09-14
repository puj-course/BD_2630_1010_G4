Consultas Álgebra Relacional
1. Top 5 selecciones con más goles

Obtiene las cinco selecciones con mayor cantidad total de goles, agrupando por selección y país y ordenando los resultados de forma descendente.

πpais, GOLES_TOTALES(TOP5(τGOLES_TOTALES DESC(γid_seleccion, pais; SUM(goles_marcados)→GOLES_TOTALES(SELECCION⋈SELECCION.id_seleccion=PARTICIPACION_PARTIDO.id_seleccionPARTICIPACION_PARTIDO))))

2. Porcentaje de ocupación por estadio

Calcula la cantidad de partidos jugados y el porcentaje promedio de ocupación de cada estadio con base en su capacidad y la asistencia registrada, ordenando los estadios de mayor a menor ocupación.

πESTADIO, ciudad, capacidad, PARTIDOS_JUGADOS, OCUPACION_PCT(τOCUPACION_PCT DESC(γESTADIO.id_estadio, ESTADIO.nombre, ESTADIO.ciudad, ESTADIO.capacidad; COUNT(PARTIDO.id_partido)→PARTIDOS_JUGADOS; ROUND(SUM(PARTIDO.asistencia_registrada)COUNT(PARTIDO.id_partido)×ESTADIO.capacidad×100, 2)→OCUPACION_PCT(ESTADIO⋈ESTADIO.id_estadio=PARTIDO.id_estadioPARTIDO)))

3. Goles a favor, goles en contra y diferencia de gol

Calcula para cada selección los goles a favor, los goles en contra y la diferencia de gol, comparando las participaciones de cada selección con las de sus rivales en los mismos partidos.

πpais, GOLES_FAVOR, GOLES_CONTRA, DIFERENCIA_GOL(τDIFERENCIA_GOL DESC(γSELECCION.id_seleccion, SELECCION.pais; SUM(PA.goles_marcados)→GOLES_FAVOR; SUM(AP.goles_marcados)→GOLES_CONTRA; SUM(PA.goles_marcados)−SUM(AP.goles_marcados)→DIFERENCIA_GOL((SELECCION⋈SELECCION.id_seleccion=PA.id_seleccionρPA(PARTICIPACION_PARTIDO))⋈PA.id_partido=AP.id_partido∧PA.id_seleccion≠AP.id_seleccionρAP(PARTICIPACION_PARTIDO))))

4. Cantidad de partidos por fase

Cuenta la cantidad de partidos disputados en cada fase del torneo, agrupando los partidos según su fase.

γfase; COUNT(id_partido)→NUM_PARTIDOS(PARTIDO)

6. Patrón de goles por partido

Identifica los partidos sin goles o con un marcador alto, calculando el total de goles por partido y clasificándolo según el patrón correspondiente. Los resultados se ordenan de mayor a menor cantidad de goles.

τGOLES_TOTALES DESC(πid_partido, id_edicion, fase, GOLES_TOTALES, PATRON(σGOLES_TOTALES=0 ∨ GOLES_TOTALES≥7(γid_partido, id_edicion, fase; SUM(goles_marcados)→GOLES_TOTALES(PARTIDO⋈PARTIDO.id_partido=PARTICIPACION_PARTIDO.id_partidoPARTICIPACION_PARTIDO))))

PATRON={′SIN GOLES′	si GOLES_TOTALES=0
′MARCADOR ALTO′	si GOLES_TOTALES≥6