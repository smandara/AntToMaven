// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.infy.controllers;

import com.infy.controllers.ApplicationConversionServiceFactoryBean;
import com.infy.entities.AntDirectory;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;

privileged aspect ApplicationConversionServiceFactoryBean_Roo_ConversionService {
    
    declare @type: ApplicationConversionServiceFactoryBean: @Configurable;
    
    public Converter<AntDirectory, String> ApplicationConversionServiceFactoryBean.getAntDirectoryToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<com.infy.entities.AntDirectory, java.lang.String>() {
            public String convert(AntDirectory antDirectory) {
                return new StringBuilder().append(antDirectory.getFolderPath()).append(' ').append(antDirectory.getConfigSRC()).append(' ').append(antDirectory.getConfigLib()).append(' ').append(antDirectory.getConfigTestpath()).toString();
            }
        };
    }
    
    public Converter<Long, AntDirectory> ApplicationConversionServiceFactoryBean.getIdToAntDirectoryConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, com.infy.entities.AntDirectory>() {
            public com.infy.entities.AntDirectory convert(java.lang.Long id) {
                return AntDirectory.findAntDirectory(id);
            }
        };
    }
    
    public Converter<String, AntDirectory> ApplicationConversionServiceFactoryBean.getStringToAntDirectoryConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, com.infy.entities.AntDirectory>() {
            public com.infy.entities.AntDirectory convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), AntDirectory.class);
            }
        };
    }
    
    public void ApplicationConversionServiceFactoryBean.installLabelConverters(FormatterRegistry registry) {
        registry.addConverter(getAntDirectoryToStringConverter());
        registry.addConverter(getIdToAntDirectoryConverter());
        registry.addConverter(getStringToAntDirectoryConverter());
    }
    
    public void ApplicationConversionServiceFactoryBean.afterPropertiesSet() {
        super.afterPropertiesSet();
        installLabelConverters(getObject());
    }
    
}
