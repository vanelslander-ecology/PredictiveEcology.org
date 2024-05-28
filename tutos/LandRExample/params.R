list(
  .globals = list('dataYear' = 2001L    ## will not be used as the layers have been pre-preped, but just in case...
                  , 'sppEquivCol' = sim$sppEquivCol
                  , 'vegLeadingProportion' = sim$vegLeadingProportion
                  , '.sslVerify' = 0L
                  , '.useCache' = sim$eventCaching),
  Biomass_borealDataPrep = list(
    'fitDeciduousCoverDiscount' = TRUE
    , 'subsetDataAgeModel' = FALSE
    , 'subsetDataBiomassModel' = FALSE
    , 'exportModels' = 'all'
    , 'fixModelBiomass' = TRUE
    , 'fireURL' = 'https://drive.google.com/file/d/1YIc_BSkPKqW60SmfpR2vDpeRGrwOFKso/view?usp=sharing'  ## use a frozen version of fire perimeter data
    , 'speciesTableAreas' = c('BSW', 'BP')
    , 'speciesUpdateFunction' = list(
      quote(LandR::speciesTableUpdate(sim$species, sim$speciesTable, sim$sppEquiv, P(sim)$sppEquivCol)),
      quote(LandR::updateSpeciesTable(speciesTable = sim$species, params = sim$speciesParams)))
    # next two are used when assigning pixelGroup membership; what resolution for
    #   age and biomass
    , 'pixelGroupAgeClass' = sim$successionTimestep
    , 'pixelGroupBiomassClass' = 100
    , 'rstLCCYear' = 2005L
    , 'useCloudCacheForStats' = FALSE
    , 'cloudFolderID' = NA
    , '.plots' = c('object', 'raw')
  )
  , Biomass_speciesParameters = list(
    'quantileAgeSubset' = list(Betu_Pap = 95, Lari_Lar = 95, Pice_Gla = 95, Pice_Mar = 95, Pinu_Ban = 99, Popu_Spp = 99)
  )
  , Biomass_core = list(
    'calcSummaryBGM' = c('start')
    , 'initialBiomassSource' = 'cohortData'
    , 'plotOverstory' = TRUE
    , 'seedingAlgorithm' = 'wardDispersal'
    , 'successionTimestep' = sim$successionTimestep
    , '.plotInitialTime' = times$start
    , '.plotInterval' = 1L
    , '.plots' = c('object', 'raw')
    , '.plotMaps' = FALSE
    , '.saveInitialTime' = NA
    , '.useCache' = sim$eventCaching[1] # experiment doesn't like when init is cached
    , '.useParallel' = sim$useParallel
  )
)
