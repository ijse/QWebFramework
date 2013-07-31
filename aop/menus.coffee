
#TODO: SAVE TO DATABASE
menuList = [
	{
		url: "/index.html"
		icon: "icon-home"
		title: "起始页"
		submenus: []
	},
	{
		url: "javascript:;"
		icon: "icon-home"
		title: "个人中心"
		submenus: [
			{
				url: "/user/profile.html"
				title: "用户资料"
			}
		]
	},
	{
		url: "javascript:;"
		icon: "icon-home"
		title: "应用中心"
		submenus: [
			{
				url: "/app/list.html"
				title: "应用列表"
			}
			{
				url: "/app/add.html"
				title: "添加应用"
			}
		]
	}
]

traverseMenu = (menus, cb)->
	rtn = menus
	hasActive = false

	if not(rtn instanceof Array)
		rtn = cb(rtn)
		hasActive = !!rtn.current if rtn
	else
		rtn.forEach (item, index)->
			_item = cb(item)
			# return if not _item
			hasActive = true if _item and _item.current # once is enough 
			return if not _item

			result = traverseMenu(_item.submenus, cb)
			rtn[index].submenus = result[0]
			rtn[index].current = result[1] if result[1]
			return

	return [rtn, hasActive]

module.exports = (app)->
	app.use (req, res, next)->
		menuListCloned = JSON.parse JSON.stringify(menuList)
		reqUrl = req.url
		if /^\/vendor/.test(reqUrl)
			next()
			return

		# 比对URL，确定当前菜单项
		menuListCloned = traverseMenu menuListCloned, (menu)->
			# return if not menu
			menu.current = true if menu and menu.url is reqUrl
			return menu

		res.locals.SidebarMenu = menuListCloned[0]
		return next()

	return 
