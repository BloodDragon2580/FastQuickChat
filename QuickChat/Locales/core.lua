function QuickChat_GetLocalization()
    local l = QCL[GetLocale()];
    if type(l) ~= "table" then
        l = QCL["enUS"]
    end
    return l
end