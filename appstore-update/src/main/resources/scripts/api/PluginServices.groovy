/*
 * Crafter Studio Web-content authoring solution
 * Copyright (C) 2007-2016 Crafter Software Corporation.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package scripts.api

import groovy.util.logging.Log
import scripts.api.ServiceFactory
import scripts.api.impl.plugins.PluginServicesImpl
/**
 * Site Services
 */
@Log
class PluginServices {
    /**
     * create the context object
     * @param applicationContext - studio application's contect (spring container etc)
     * @param request - web request if in web request context
     */
    static createContext(applicationContext, request) {
        return ServiceFactory.createContext(applicationContext, request)
    }
  
    /**  
     * Install a plugin from romote source.  
     * @param siteId, the site where the plugin will be installed
     * @param pluginDownloadUrl, url where plugin can be acquired
     * @return true if success, false otherise
     */
    static installPlugin(context, siteId, pluginDownloadUrl) {
        def pluginServicesImpl = ServiceFactory.getPluginServices(context)

        return pluginServicesImpl.installPlugin(siteId, pluginDownloadUrl)
    }

    /**
     * Uninstall a plugin 
     * @param siteId, the site where the plugin will be installed
     * @param pluginId
     * @return true if success, false otherise
     */
    static uninstallPlugin(context, siteId, pluginId) {
        return false 
    }

    /** 
     * given a siteId, return a list of installed plugins
     * @param siteId, the site where the plugin will be installed
     * @return an array of installed plugin items
     */
    static getInstalledPlugins(context, siteId) {
        def pluginServicesImpl = ServiceFactory.getPluginServices(context)

        return pluginServicesImpl.getInstalledPlugins(siteId)
    }

    /**
     * enable a plugin
     */
    static enablePlugin(context, siteId, pluginId) {
        return false
    }

    /**
     * disableable a plugin
     */
    static disablePlugin(context, siteId, pluginId) {
        return true
    }
}
