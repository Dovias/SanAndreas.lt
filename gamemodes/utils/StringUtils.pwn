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