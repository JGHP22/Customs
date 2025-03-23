--Necrovalley Gate
--scripted by ChatGPT

local s,id=GetID()
function s.initial_effect(c)
    -- Efeito 1: Adicionar 1 monstro "Gravekeeper's" do seu Deck para sua mão
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,0))
    e1:SetCategory(CATEGORY_TOHAND + CATEGORY_SEARCH)
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetRange(LOCATION_SZONE)
    e1:SetCountLimit(1,id)
    e1:SetTarget(s.thtg)
    e1:SetOperation(s.thop)
    c:RegisterEffect(e1)
end

-- Função para filtrar monstros "Gravekeeper's" no Deck
function s.thfilter(c)
    return c:IsSetCard(0x2e) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

-- Função de alvo: selecionar um monstro "Gravekeeper's" para adicionar à mão
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

-- Função de operação: adicionar o monstro "Gravekeeper's" à sua mão
function s.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
    if #g>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end