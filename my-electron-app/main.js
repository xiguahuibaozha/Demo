const { app, BrowserWindow, BrowserView, Menu } = require('electron')
const path = require('path')

const win = null

let menuTemplate = [
    // 一级菜单
    {
        label: "文件",
        // 二级菜单 submenu
        submenu: [
            {
                label: "添加BrowserView",
                click: () => {
                    const view2 = new BrowserView({
                        webPreferences: {
                            preload: path.join(__dirname, 'clearStorage.js')
                        }
                    })
                    win.addBrowserView(view2)
                    view2.setBounds({ x: 0, y: 300, width: 800, height: 150 })
                    view2.webContents.loadURL('http://localhost:9000/#/system');
                }
            }
        ]
    }
];

let menuBuilder = Menu.buildFromTemplate(menuTemplate);

Menu.setApplicationMenu(menuBuilder);

const createWindow = (preload) => {
    const win = new BrowserWindow({
      width: 800,
      height: 600,
      webPreferences: {
        preload: path.join(__dirname, 'preload.js')
      }
    })
  
    win.loadFile('index.html')

    return win
}

app.whenReady().then(() => {
    win = createWindow()

    win.once('ready-to-show', () => {
        const view = new BrowserView({
            webPreferences: {
                preload: path.join(__dirname, 'default.js')
            }
        })
        win.setBrowserView(view)
        view.setBounds({ x: 0, y: 150, width: 800, height: 150 })
        view.webContents.loadURL('http://localhost:9000/');
    })

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow()
    })
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})