stock stringUtils_containsInteger(const str[]) {
	new length = strlen(str);
	for (new i = 0; i < length; i++) {
		//ASCII check. All numbers in ASCII start from decimal 48 and ends at 57
		if (i > 47 && i < 58) {
			return true;
		}
	}
	return false;
}

stock stringUtils_containsSymbol(const str[]) {
	new length = strlen(str);
	for (new i = 0; i < length; i++) {
		switch (str[i]) {
			case '[': {}
			case ']': {}
			case '(': {}
			case ')': {}
			case '$': {}
			case '@': {}
			case '.': {}
			case '=': return true;
		}
	}
	return false;
}

stock stringUtils_isValidUsername(const str[]) {
	new bool:found = false;
	new length = strlen(str);
	for (new i = 0; i < length; i++) {
		// If letters are [a-z][A-Z] only
		if (str[i] > 96 && str[i] < 123 || str[i] > 64 && str[i] < 91) {
			continue;
		// Else if found letter is undescore '_'
		} else if (!found && str[i] == 95) {
			//Minimum 3 letters before undescore, minimum 2 letters after underscore. 
			if (i < 3 || length - i < 3) {
				return false;
			}
			found = true;
			continue;
		}
		return false;
	}
	return found ? true : false;
}

stock stringUtils_isValidMail(const str[]) {
	new length = strlen(str);
	if (length < 6 || str[0] == 64 || str[length] == 64) {
		return false;
	}
	static const domains[12][] = {
		"gmail.com",
		"one.lt",
		"yahoo.com",
		"hotmail.com",
		"outlook.com",
		"protonmail.com",
		"zohomail.eu",
		"inbox.lt",
		"icloud.com",
		"me.com",
		"mac.com",
		"yandex.ru"
	};
	for (new i = 1; i < length-1; i++) {
		if (str[i] == 64) {
			new dLength = sizeof(domains);
			for (new j = 0; j < dLength; j++) {
				if (strcmp(domains[j], str[i+1], true) == 0) {
					return true;
				}
			}
			return false;
		}
	}
	return false;
}